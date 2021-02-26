import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ps_mesainc/app/modules/feed/domain/entities/news_page.dart';
import 'package:ps_mesainc/app/modules/feed/domain/repositories/news_repository.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/logged_user.dart';

abstract class GetNewsPage {
  Future<Either<Exception, NewsPage>> call(int pageNumber, LoggedUser user);
}

@Injectable(singleton: false)
class GetNewsPageImpl implements GetNewsPage {
  final NewsRepository repository;

  GetNewsPageImpl(this.repository);

  @override
  Future<Either<Exception, NewsPage>> call(int pageNumber, LoggedUser user) {
    return repository.getNewsPage(pageNumber, user);
  }
}
