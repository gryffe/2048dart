part of domain_tests;


void colorTests(){
  group('colors',(){
    test('wellKnownColorCodesExceptWhiteAndBlack',(){
      expect(Colors.wellKnownColorCodesExceptWhiteAndBlack.length,15);
    });
  });
}


