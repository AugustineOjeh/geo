class Offers {
  static const basic = <Map<String, dynamic>>[
    {'available': true, 'benefit': '50% refund on cancellations'},
    {'available': true, 'benefit': 'Book any same-week slot'},
    {'available': true, 'benefit': 'Instant booking confirmation'},
    {'available': false, 'benefit': 'No rescheduling'},
    {'available': false, 'benefit': 'No guaranteed availability'},
  ];

  static const standard = <Map<String, dynamic>>[
    {'available': true, 'benefit': 'Minimum of 10 classes'},
    {'available': true, 'benefit': 'Book ahead (30-day calendar)'},
    {'available': true, 'benefit': '75% refund on cancellations'},
    {'available': true, 'benefit': 'Guaranteed teacher availability'},
    {'available': true, 'benefit': 'Reschedule missed classes'},
    {'available': true, 'benefit': 'Class notes & presentations'},
    {'available': true, 'benefit': 'Monthly progress check-ins'},
  ];

  static const premium = <Map<String, dynamic>>[
    {'available': true, 'benefit': 'Minimum of 20 classes'},
    {'available': true, 'benefit': 'Book ahead (45-day calendar)'},
    {'available': true, 'benefit': '100% refund on cancellations'},
    {'available': true, 'benefit': 'Class recordings (90-day access)'},
    {'available': true, 'benefit': 'Collaborative Whiteboard (90-day access)'},
  ];

  static const special = <Map<String, dynamic>>[
    {'available': true, 'benefit': 'Free 25-min introductory call'},
    {'available': true, 'benefit': 'Custom-designed curriculum'},
    {'available': true, 'benefit': 'Extended class durations'},
    {'available': true, 'benefit': 'AI-powered adaptive teaching'},
    {'available': true, 'benefit': 'Biweekly parent feedback'},
    {'available': true, 'benefit': 'Flexible pacing'},
  ];
}
