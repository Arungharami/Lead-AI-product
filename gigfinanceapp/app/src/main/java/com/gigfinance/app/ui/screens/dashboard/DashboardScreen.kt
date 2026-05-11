package com.gigfinance.app.ui.screens.dashboard

import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.runtime.Composable
import androidx.compose.runtime.collectAsState
import androidx.compose.runtime.getValue
import androidx.compose.ui.Modifier
import androidx.compose.ui.unit.dp
import com.gigfinance.app.ui.components.SummaryCard

@Composable
fun DashboardScreen(viewModel: DashboardViewModel, onAddClick: () -> Unit) {
    val state by viewModel.uiState.collectAsState()

    Scaffold(
        floatingActionButton = {
            FloatingActionButton(onClick = onAddClick) { Text("+") }
        }
    ) { padding ->
        LazyColumn(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding),
            contentPadding = PaddingValues(16.dp),
            verticalArrangement = Arrangement.spacedBy(12.dp)
        ) {
            item { Text("Gig Worker Finance", style = MaterialTheme.typography.headlineMedium) }
            item { SummaryCard("Total Income", state.totalIncome) }
            item { SummaryCard("Total Expenses", state.totalExpenses) }
            item { SummaryCard("Net Profit", state.netProfit) }
            item { SummaryCard("Tax Jar (25%)", state.taxJar) }
            item { SummaryCard("Safe to Spend", state.safeToSpend) }
            items(state.transactions) { txn ->
                Column {
                    Text(txn.title, style = MaterialTheme.typography.titleMedium)
                    Text("${txn.type}: $${"%.2f".format(txn.amount)}")
                }
            }
        }
    }
}
