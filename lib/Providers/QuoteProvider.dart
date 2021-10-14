import 'package:firstapp/Models/quote.dart';

class QuoteProvider{
  final List<quoteModel> quotes = [
    quoteModel(
      quote: 'A friend knows the song in my heart and sings it to me when my memory fails.',
      author: 'Donna Roberts',
    ),
  ];
  List<quoteModel> get fetchQuotesList{
    return [...quotes];
  }
}