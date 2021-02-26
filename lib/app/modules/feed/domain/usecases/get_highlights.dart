import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:ps_mesainc/app/modules/feed/domain/entities/news.dart';
import 'package:ps_mesainc/app/modules/feed/domain/repositories/news_repository.dart';
import 'package:ps_mesainc/app/modules/login/domain/entities/logged_user.dart';

abstract class GetHighlights {
  Future<Either<Exception, List<News>>> call(LoggedUser user);
}

@Injectable(singleton: false)
class GetHighlightsImpl implements GetHighlights {
  final NewsRepository repository;

  GetHighlightsImpl(this.repository);

  @override
  Future<Either<Exception, List<News>>> call(LoggedUser user) {
    return repository.getHighlights(user);
  }
}
