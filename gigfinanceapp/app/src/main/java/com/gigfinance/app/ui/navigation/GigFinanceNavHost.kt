package com.gigfinance.app.ui.navigation

import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.ui.platform.LocalContext
import androidx.lifecycle.viewmodel.compose.viewModel
import androidx.navigation.compose.NavHost
import androidx.navigation.compose.composable
import androidx.navigation.compose.rememberNavController
import androidx.room.Room
import com.gigfinance.app.data.local.AppDatabase
import com.gigfinance.app.data.repository.TransactionRepository
import com.gigfinance.app.ui.screens.addtransaction.AddTransactionScreen
import com.gigfinance.app.ui.screens.addtransaction.AddTransactionViewModel
import com.gigfinance.app.ui.screens.addtransaction.AddTransactionViewModelFactory
import com.gigfinance.app.ui.screens.dashboard.DashboardScreen
import com.gigfinance.app.ui.screens.dashboard.DashboardViewModel
import com.gigfinance.app.ui.screens.dashboard.DashboardViewModelFactory

private const val DASHBOARD = "dashboard"
private const val ADD_TRANSACTION = "add_transaction"

@Composable
fun GigFinanceNavHost() {
    val navController = rememberNavController()
    val context = LocalContext.current

    val db = remember {
        Room.databaseBuilder(context, AppDatabase::class.java, "gig_finance_db").build()
    }
    val repository = remember { TransactionRepository(db.transactionDao()) }

    NavHost(navController = navController, startDestination = DASHBOARD) {
        composable(DASHBOARD) {
            val vm: DashboardViewModel = viewModel(factory = DashboardViewModelFactory(repository))
            DashboardScreen(vm) { navController.navigate(ADD_TRANSACTION) }
        }
        composable(ADD_TRANSACTION) {
            val vm: AddTransactionViewModel = viewModel(factory = AddTransactionViewModelFactory(repository))
            AddTransactionScreen(vm) { navController.popBackStack() }
        }
    }
}
