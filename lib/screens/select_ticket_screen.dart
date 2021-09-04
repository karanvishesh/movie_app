import 'package:flutter/material.dart';
import 'package:movie_app/constants.dart';
import 'package:movie_app/screens/landing_page.dart';

class SelectSeatPage extends StatefulWidget {
  SelectSeatPage(
      {Key? key, required this.movieTitle, required this.ticketAmount})
      : super(key: key);
  final String movieTitle;
  final String ticketAmount;

  @override
  State<SelectSeatPage> createState() => _SelectSeatPageState();
}

class _SelectSeatPageState extends State<SelectSeatPage> {
  int totalSeats = 42;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBodyColor,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.movieTitle,
              style: TextStyle(color: Colors.white),
            ),
            Text(
              "${widget.ticketAmount} Tickets",
              style: TextStyle(color: Colors.white, fontSize: 16),
            )
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Text(
                'Screen',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 380,
              child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 6),
                  itemCount: totalSeats,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return BuildSeats(
                      index: index,
                      ticketAmount: int.parse(widget.ticketAmount),
                    );
                  }),
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              height: 50,
              minWidth: double.infinity,
              color: Colors.blue,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LandingPage()),
                );
              },
              child: Text(
                "Book",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class BuildSeats extends StatefulWidget {
  BuildSeats({Key? key, required this.index, required this.ticketAmount})
      : super(key: key);
  final int index;
  final int ticketAmount;

  @override
  State<BuildSeats> createState() => _BuildSeatsState();
}

class _BuildSeatsState extends State<BuildSeats> {
  var alphas = ['A', 'B', 'C', 'D', 'E', 'F', 'G'];

  int totalSeats = 42;

  bool isSelected = false;
  var seatSelected = 0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (seatSelected <= widget.ticketAmount) {
            print(widget.ticketAmount);
            isSelected = !isSelected;
            if (isSelected == true) {
              seatSelected++;
            }
          }
        });
      },
      child: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.green, width: 4),
            color: isSelected ? Colors.green : Colors.transparent),
        child: Center(
            child: Text(
          alphas[0] + (widget.index % 7 + 1).toString(),
          style: TextStyle(color: Colors.white),
        )),
      ),
    );
  }
}
