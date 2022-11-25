
import 'package:expense_tracker/custom_list/helper_function&list.dart';
import 'package:expense_tracker/pages/expense_add_page.dart';
import 'package:expense_tracker/pages/loan_page.dart';
import 'package:expense_tracker/pages/multi_screen_pages.dart';
import 'package:expense_tracker/providers/expence_provider.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../utils/pie_cart.dart';
import '../utils/notifications_util.dart';


class HomePage extends StatefulWidget {
  static const String routeName = "/homepage";

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void didChangeDependencies() {
    Provider.of<ExpenceProvider>(context,listen: false).getAllExpence();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: (){
          Navigator.pushNamed(context, ExpenseAddPage.routeName);
        },
        child:const Icon(Icons.add,size: 30,),
      ),
      backgroundColor:HexColor("#D0E0E8") ,
      appBar: AppBar(
        title: const Text("Expense Tracker"),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
              onPressed: (){
                Navigator.pushNamed(context, MultiScreenPages.routeName);
              },
              child:const Text("Show Catagory")
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  )
              ),
              onPressed: (){
                Navigator.pushNamed(context, LoanPage.routeName);
              },
              child:const Text("Show loan")
          ),
        ],
        elevation: 0,
      ),
      body: Consumer<ExpenceProvider>(
            builder:(context,provider,child)=> Column(
              children: [
                Container(
                  color:HexColor("#D0E0E8") ,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 12.0),
                        child: Text(
                          "Total Expenses: \$ ${provider.gettotalexpence()}", style: const TextStyle(fontSize: 28, color: Colors.green),
                        ),
                      ),
                      const SizedBox(height: 22,),
                      Pie_chart(context,provider),
                      Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Row(
                          children: const [
                            Text('Expences',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
                            Spacer(),
                            Text('Cost',style: TextStyle(color: Colors.red,fontSize: 18, fontWeight: FontWeight.w500)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child:ListView.builder(
                    itemCount:provider.expenceList.length,
                    itemBuilder: (context, index) {
                      final expence = provider.expenceList[index];
                        return Padding(
                        padding: const EdgeInsets.only(left: 10,right: 10,top: 7),
                        child: ShowListTile(expence),
                      );
                    },
                  ),
                ),

              ],
            ),
          ),
    );
  }



}
