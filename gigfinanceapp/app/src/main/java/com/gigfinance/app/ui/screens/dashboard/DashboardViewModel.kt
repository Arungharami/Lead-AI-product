package com.gigfinance.app.ui.screens.dashboard

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.viewModelScope
import com.gigfinance.app.data.local.TransactionEntity
import com.gigfinance.app.data.repository.TransactionRepository
import com.gigfinance.app.domain.model.TransactionType
import kotlinx.coroutines.flow.SharingStarted
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.flow.stateIn

data class DashboardUiState(
    val transactions: List<TransactionEntity> = emptyList(),
    val totalIncome: Double = 0.0,
    val totalExpenses: Double = 0.0,
    val netProfit: Double = 0.0,
    val taxJar: Double = 0.0,
    val safeToSpend: Double = 0.0
)

class DashboardViewModel(private val repository: TransactionRepository) : ViewModel() {
    val uiState: StateFlow<DashboardUiState> = repository.observeTransactions().map { transactions ->
        val income = transactions.filter { it.type == TransactionType.INCOME }.sumOf { it.amount }
        val expense = transactions.filter { it.type == TransactionType.EXPENSE }.sumOf { it.amount }
        val net = income - expense
        val tax = (net * 0.25).coerceAtLeast(0.0)
        val safe = (net - tax).coerceAtLeast(0.0)

        DashboardUiState(
            transactions = transactions,
            totalIncome = income,
            totalExpenses = expense,
            netProfit = net,
            taxJar = tax,
            safeToSpend = safe
        )
    }.stateIn(viewModelScope, SharingStarted.WhileSubscribed(5000), DashboardUiState())
}

class DashboardViewModelFactory(private val repository: TransactionRepository) : ViewModelProvider.Factory {
    override fun <T : ViewModel> create(modelClass: Class<T>): T {
        return DashboardViewModel(repository) as T
    }
}
