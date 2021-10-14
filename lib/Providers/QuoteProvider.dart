import 'package:firstapp/Models/quote.dart';

class QuoteProvider{
  final List<quoteModel> quotes = [
    quoteModel(
      quote: 'A friend knows the song in my heart and sings it to me when my memory fails.',
      author: 'Donna Roberts',
    ),
    quoteModel(
      author: 'Helen Keller',
      quote: 'I would rather walk with a friend in the dark, than alone in the light.'
    ),
    quoteModel(
      author: 'Donna Roberts',
      quote: 'A friend knows the song in my heart and sings it to me when my memory fails.'
    ),
    quoteModel(
      quote: 'What draws people to be friends is that they see the same truth. They share it.',
      author: 'C.S Lewis',
    ),
    quoteModel(
      author: 'Nicole Richie',
      quote: 'True friends are like diamonds—bright, beautiful, valuable, and always in style.',
    ),
    quoteModel(
      author: 'Heidi Wills',
      quote: 'A friend is someone who makes it easy to believe in yourself.',
    ),
    quoteModel(
      author: 'Jean de La Fontaine',
      quote: 'Rare as is true love, true friendship is rarer.',
    ),
  ];
  List<quoteModel> get fetchQuotesList{
    return [...quotes];
  }
}