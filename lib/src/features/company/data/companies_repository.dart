
abstract class CompaniesRepository {

}

class SupabaseCompaniesRepository implements CompaniesRepository{
  static String companyTable() => 'company';
  static String companyBucket() => 'companies';
  static String selectCompanyBucketFilePath(int id) => '${id.toString()}/companyImage';
}