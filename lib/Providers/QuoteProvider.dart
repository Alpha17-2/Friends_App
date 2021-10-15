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
    quoteModel(
      author: 'Elbert Hubbard',
      quote: 'A friend is someone who knows all about you and still loves you.',
    ),
    quoteModel(
      author: 'Alfred Tennyson',
      quote: 'If I had a flower for every time I thought of you...I could walk through my garden forever.',
    ),
    quoteModel(
      author: 'Aristotle',
      quote: 'What is a friend? A single soul dwelling in two bodies.',
    ),
    quoteModel(
      author: 'Socrates',
      quote: 'Be slow to fall into friendship; but when thou art in, continue firm & constant.',
    ),
    quoteModel(
      author: 'William Shakespeare',
      quote: 'A friend is one that knows you as you are, understands where you have been, accepts what you have become, and still, gently allows you to grow.',
    ),
    quoteModel(
      author: 'Plutarch',
      quote: 'I don’t need a friend who changes when I change and who nods when I nod; my shadow does that much better.',
    ),
    quoteModel(
      author: 'Friedrich Nietzsche',
      quote: 'Love is blind; friendship closes its eyes.',
    ),
    quoteModel(
      author: 'Mark Twain',
      quote: 'Good friends, good books, and a sleepy conscience: this is the ideal life.',
    ),
  ];
  List<quoteModel> get fetchQuotesList{
    return [...quotes];
  }
}