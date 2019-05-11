import 'dart:html';

void main() {
 
  var buttonall = querySelectorAll('.button');
  var buttonReset = querySelector('#reset');
  var winnerIndicator = querySelector('#winner');
  var grid = [
    [' ',' ',' '],
    [' ',' ',' '],
    [' ',' ',' ']];

  buttonReset.onClick.listen((data){
    var grid = [
      [' ',' ',' '],
      [' ',' ',' '],
      [' ',' ',' ']];
    updateVisual(grid, buttonall);
    gamePlay(grid, buttonall,winnerIndicator);
    winnerIndicator.innerHtml = " ";
  });
  
  gamePlay(grid, buttonall,winnerIndicator);

}

void changeGrid(var grid, var id,var symb){
    var x = int.parse(id[0]);
    var y = int.parse(id[1]);
    grid[x][y] = symb;
}

List<int> getButtonID(var id){
  return [int.parse(id[0]),int.parse(id[1])];
}

String checkEndgame(var grid){
  for(int i=0;i<3;i++){
    if(grid[i][0]==grid[i][1] && grid[i][1] == grid[i][2]){
      return grid[i][0];
    }
  }

  for(int i=0;i<3;i++){
    if(grid[0][i]==grid[1][i] && grid[1][i] == grid[2][i]){
      return grid[0][i];
    }
  }

  if(grid[0][0] == grid[1][1] && grid[1][1] == grid[2][2]){
    return grid[1][1];
  }

  if(grid[0][2] == grid[1][1] && grid[1][1] == grid[2][0]){
    return grid[1][1];
  }
  return " ";

}

void updateVisual(var grid,var buttonall){
  for(var button in buttonall){
    var v = getButtonID(button.id);
    button.innerHtml = grid[v[0]][v[1]];
  }
}

void gamePlay(var grid, var buttonall,var winnerIndicator){
  var symbList = ['X','O'];
  var index = 0;
  var currentSym = symbList[index];
  for(var button in buttonall){
    button.onClick.listen((onData){
      var x = getButtonID(button.id)[0];
      var y = getButtonID(button.id)[1];
      if(grid[x][y] == " "){
        index+=1;
        changeGrid(grid, button.id, currentSym);
        currentSym = symbList[index%2];
        updateVisual(grid, buttonall);
        print(grid);
        print(checkEndgame(grid));
        winnerIndicator.innerHtml = checkEndgame(grid);
      }
    });
  }
}