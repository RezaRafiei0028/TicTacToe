import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isTurnO = true;
  List<String> listOX = ['', '', '', '', '', '', '', '', ''];
  int filledBoxes = 0; //for draw situation
  bool gameHasResult = false;
  int scoreX = 0;
  int scoreO = 0;
  String winnerTittle = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
        centerTitle: true,
        backgroundColor: Colors.grey[900],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              clearGame();
            },
            icon: Icon(
              Icons.refresh_rounded,
              size: 35,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            getScoreBoard(),
            SizedBox(
              height: 20.0,
            ),
            getGridView(),
            getResultButton(),
            SizedBox(
              height: 50,
            ),
            getTurn(),
          ],
        ),
      ),
    );
  }

  Widget getTurn() {
    return Text(
      isTurnO ? 'Turn O' : 'Turn X', //hamon If else
      style: TextStyle(
        fontSize: 25,
        color: Colors.white,
      ),
    );
  }

  Widget getGridView() {
    return Expanded(
      //age expand nakonim error mide,mishe az Container ham estefade kard
      child: GridView.builder(
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              tapped(index);
            },
            child: Container(
              child: Center(
                child: Text(
                  listOX[index],
                  style: TextStyle(
                      fontSize: 50,
                      color: listOX[index] == 'O' ? Colors.red : Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
            ),
          );
        },
        itemCount: 9,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
      ),
    );
  }

  void tapped(int index) {
    setState(
      () {
        if (gameHasResult == true) {
          return; //baraye hal bug akhari
        }

        if (listOX[index] != '') {
          return;
          //return inja be mani ine ke compiler az block in method biron biyad
        }

        if (isTurnO) {
          listOX[index] = 'O';
          filledBoxes += 1;
        } else {
          listOX[index] = 'X';
          filledBoxes += 1;
        }
        isTurnO = !isTurnO;

        checkWinner();

        // if (isTurnO && listOX[index] == '') {
        //   listOX[index] = 'O';
        //   isTurnO = false;
        // }
        // if (!isTurnO && listOX[index] == '') {
        //   listOX[index] = 'X';
        //   isTurnO = true;
        // }
      },
    );
  }

  void checkWinner() {
    if (listOX[0] == listOX[1] && listOX[0] == listOX[2] && listOX[0] != '') {
      setResult(listOX[0], '${listOX[0]} is winner!!!');
      return;
    }
    if (listOX[3] == listOX[4] && listOX[3] == listOX[5] && listOX[3] != '') {
      setResult(listOX[3], '${listOX[3]} is winner!!!');
      return;
    }
    if (listOX[6] == listOX[7] && listOX[6] == listOX[8] && listOX[6] != '') {
      setResult(listOX[6], '${listOX[6]} is winner!!!');
      return;
    }
    if (listOX[0] == listOX[3] && listOX[0] == listOX[6] && listOX[0] != '') {
      setResult(listOX[0], '${listOX[0]} is winner!!!');
      return;
    }
    if (listOX[1] == listOX[4] && listOX[1] == listOX[7] && listOX[1] != '') {
      setResult(listOX[1], '${listOX[1]} is winner!!!');
      return;
    }
    if (listOX[2] == listOX[5] && listOX[2] == listOX[8] && listOX[2] != '') {
      setResult(listOX[2], '${listOX[2]} is winner!!!');
      return;
    }
    if (listOX[0] == listOX[4] && listOX[0] == listOX[8] && listOX[0] != '') {
      setResult(listOX[0], '${listOX[0]} is winner!!!');
      return;
    }
    if (listOX[2] == listOX[4] && listOX[2] == listOX[6] && listOX[2] != '') {
      setResult(listOX[2], '${listOX[2]} is winner!!!');
      return;
    }
    if (filledBoxes == 9) {
      setResult('', 'Draw !!!');
    }
  }

  void setResult(String checkWinner, String title) {
    setState(() {
      gameHasResult = true;
      winnerTittle = title;
      if (checkWinner == 'X') {
        scoreX += 1;
      }
      if (checkWinner == 'O') {
        scoreO += 1;
      }
    });
  }

  void clearGame() {
    setState(
      () {
        for (int i = 0; i < listOX.length; i++) {
          listOX[i] = '';
        }
        filledBoxes = 0;
        isTurnO = true;
        gameHasResult = false;
      },
    );
  }

  Widget getResultButton() {
    return Visibility(
      visible: gameHasResult,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(),
          side: BorderSide(
            width: 2,
            color: Colors.white,
          ),
        ),
        onPressed: () {
          gameHasResult = false;
          clearGame();
        },
        child: Text(
          '${winnerTittle} Play again!',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget getScoreBoard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      //Mishe bejaye khat bala Column haro Expanded kard(to video hamin karo kard)
      children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Player O',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                '${scoreO}',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ],
        ),
        Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                'Player X',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                '${scoreX}',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
