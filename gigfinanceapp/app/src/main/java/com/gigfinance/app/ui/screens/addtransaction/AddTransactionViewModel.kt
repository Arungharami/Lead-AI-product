package com.gigfinance.app.ui.screens.addtransaction

import androidx.lifecycle.ViewModel
import androidx.lifecycle.ViewModelProvider
import androidx.lifecycle.viewModelScope
import com.gigfinance.app.data.local.TransactionEntity
import com.gigfinance.app.data.repository.TransactionRepository
import com.gigfinance.app.domain.model.TransactionType
import kotlinx.coroutines.flow.MutableStateFlow
import kotlinx.coroutines.flow.StateFlow
import kotlinx.coroutines.flow.asStateFlow
import kotlinx.coroutines.flow.update
import kotlinx.coroutines.launch

data class AddTransactionUiState(
    val title: String = "",
    val amount: String = "",
    val selectedType: TransactionType = TransactionType.INCOME,
    val error: String? = null
)

class AddTransactionViewModel(private val repository: TransactionRepository) : ViewModel() {
    private val _uiState = MutableStateFlow(AddTransactionUiState())
    val uiState: StateFlow<AddTransactionUiState> = _uiState.asStateFlow()

    fun onTitleChange(value: String) = _uiState.update { it.copy(title = value, error = null) }
    fun onAmountChange(value: String) = _uiState.update { it.copy(amount = value, error = null) }
    fun onTypeChange(type: TransactionType) = _uiState.update { it.copy(selectedType = type) }

    fun saveTransaction(onSaved: () -> Unit) {
        val state = _uiState.value
        val amountValue = state.amount.toDoubleOrNull()

        when {
            state.title.isBlank() -> _uiState.update { it.copy(error = "Title is required") }
            amountValue == null || amountValue <= 0.0 -> _uiState.update { it.copy(error = "Enter a valid amount") }
            else -> viewModelScope.launch {
                repository.addTransaction(
                    TransactionEntity(
                        title = state.title.trim(),
                        amount = amountValue,
                        type = state.selectedType
                    )
                )
                _uiState.value = AddTransactionUiState()
                onSaved()
            }
        }
    }
}

class AddTransactionViewModelFactory(private val repository: TransactionRepository) : ViewModelProvider.Factory {
    override fun <T : ViewModel> create(modelClass: Class<T>): T {
        return AddTransactionViewModel(repository) as T
    }
}
