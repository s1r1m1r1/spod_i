import 'package:serverpod/serverpod.dart';

import 'generated/company.dart';

class CompanyEndpoint extends Endpoint {
  Future<bool> isLegit(Session session, Company company) async {
    // Check if the company has the foundedDate set and that it
    // has been around for more than one year.

    if (company.foundedDate == null) {
      return false;
    }

    var oneYearAgo = DateTime.now().subtract(Duration(days: 365));
    return company.foundedDate!.isBefore(oneYearAgo);
  }
}
