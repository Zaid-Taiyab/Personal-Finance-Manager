import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/database_service.dart';
import '../models/transaction_model.dart';
import '../services/auth_service.dart';

class DashboardScreen extends StatelessWidget {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Provider.of<AuthService>(context, listen: false).logout();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: _amountController,
                  decoration: InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    final transaction = Transaction(
                      id: DateTime.now().toString(),
                      description: _descriptionController.text,
                      amount: double.parse(_amountController.text),
                      date: DateTime.now(),
                    );
                    Provider.of<DatabaseService>(context, listen: false).addTransaction(transaction);
                  },
                  child: Text('Add Transaction'),
                ),
              ],
            ),
          ),
          Expanded(
            child: Consumer<DatabaseService>(
              builder: (context, databaseService, _) {
                return ListView.builder(
                  itemCount: databaseService.transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = databaseService.transactions[index];
                    return ListTile(
                      title: Text(transaction.description),
                      subtitle: Text(transaction.date.toString()),
                      trailing: Text('\$${transaction.amount.toString()}'),
                      onLongPress: () {
                        databaseService.removeTransaction(transaction.id);
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
