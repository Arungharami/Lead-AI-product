package com.gigfinance.app.data.repository

import com.gigfinance.app.data.local.TransactionDao
import com.gigfinance.app.data.local.TransactionEntity
import kotlinx.coroutines.flow.Flow

class TransactionRepository(private val dao: TransactionDao) {
    fun observeTransactions(): Flow<List<TransactionEntity>> = dao.observeTransactions()

    suspend fun addTransaction(transaction: TransactionEntity) {
        dao.insertTransaction(transaction)
    }
}
