part of domain_tests;



void math_tests(){
  group('math',(){
    test('log',(){
      var mathLog = log(16)*LOG2E;
      var twoToThePowerOf = 2;
      expect(mathLog,4);
      
      for(int i = 2; i < 10; i++){
        var calc = pow(2,i);
        var actual = log(calc)*LOG2E;
        expect(actual.round(),i);
      }
    });
  });  
  
}

