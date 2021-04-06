class TravelBooking {
  static const TRIPID = 'trip_id';
  static const PASSENGERCOUNT = 'number_of_passenger';
  static const MAINEMAIL = 'email';
  static const PASSENGERNAMES = 'name';
  static const PASSENGERTITLES = 'title';
  static const PASSENGERIDENTITIES = 'identity_type';
  static const IDENTITYNUMBERS = 'identity_number';
  static const PASSENGERMOBILE = 'mobile';
  static const PASSENGEREMAIL = 'email';

  int _tripID;
  int _passengerCount;
  // String _mainEmail;
  List<String> _names;
  List<int> _titles;
  List<int> _identityType;
  List<String> _identityNumbers;
  List<String> _mobileNumbers;
  List<String> _emailAddresses;

  Map<String, dynamic> toJson() => {
        TRIPID: _tripID,
        PASSENGERCOUNT: _passengerCount,
        // MAINEMAIL: _mainEmail,
        PASSENGERNAMES:_names,
        PASSENGERTITLES :_titles,
        PASSENGERIDENTITIES:_identityType,
        IDENTITYNUMBERS:_identityNumbers,
        PASSENGERMOBILE:_mobileNumbers,
        PASSENGEREMAIL:_emailAddresses
      };
}
