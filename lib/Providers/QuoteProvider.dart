import 'package:firstapp/Models/quote.dart';

class QuoteProvider {
  final List<quoteModel> quotes = [
    quoteModel(
      quote:
          'A friend knows the song in my heart and sings it to me when my memory fails.',
      author: 'Donna Roberts',
    ),
    quoteModel(
        author: 'Helen Keller',
        quote:
            'I would rather walk with a friend in the dark, than alone in the light.'),
    quoteModel(
        author: 'Donna Roberts',
        quote:
            'A friend knows the song in my heart and sings it to me when my memory fails.'),
    quoteModel(
      quote:
          'What draws people to be friends is that they see the same truth. They share it.',
      author: 'C.S Lewis',
    ),
    quoteModel(
      author: 'Nicole Richie',
      quote:
          'True friends are like diamonds—bright, beautiful, valuable, and always in style.',
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
      quote:
          'If I had a flower for every time I thought of you...I could walk through my garden forever.',
    ),
    quoteModel(
      author: 'Aristotle',
      quote: 'What is a friend? A single soul dwelling in two bodies.',
    ),
    quoteModel(
      author: 'Socrates',
      quote:
          'Be slow to fall into friendship; but when thou art in, continue firm & constant.',
    ),
    quoteModel(
      author: 'William Shakespeare',
      quote:
          'A friend is one that knows you as you are, understands where you have been, accepts what you have become, and still, gently allows you to grow.',
    ),
    quoteModel(
      author: 'Plutarch',
      quote:
          'I don’t need a friend who changes when I change and who nods when I nod; my shadow does that much better.',
    ),
    quoteModel(
      author: 'Friedrich Nietzsche',
      quote: 'Love is blind; friendship closes its eyes.',
    ),
    quoteModel(
      author: 'Mark Twain',
      quote:
          'Good friends, good books, and a sleepy conscience: this is the ideal life.',
    ),
    quoteModel(
      author: "Elisabeth Foley",
      quote:
          "The most beautiful discovery true friends make is that they can grow separately without growing apart.",
    ),
    quoteModel(
      author: "Anais Nin",
      quote:
          "Each friend represents a world in us, a world possibly not born until they arrive, and it is only by this meeting that a new world is born.",
    ),
    quoteModel(
      author: "Tennessee Williams",
      quote:
          "Life is partly what we make it, and partly what it is made by the friends we choose.",
    ),
    quoteModel(
      author: "Maria Shriver",
      quote:
          "When the world is so complicated, the simple gift of friendship is within all of our hands.",
    ),
    quoteModel(
      author: "Ed Cunningham",
      quote:
          "Friends are those rare people who ask how we are and then wait to hear the answer.",
    ),
    quoteModel(
      author: "G. Randolf",
      quote:
          "Truly great friends are hard to find, difficult to leave, and impossible to forget.",
    ),
    quoteModel(
      author: "Irish Proverb",
      quote:
          "A good friend is like a four-leaf clover; hard to find and lucky to have.",
    ),
    quoteModel(
      author: "Helen Keller",
      quote:
          "True friends are never apart, maybe in distance but never in heart.",
    ),
    quoteModel(
      author: "Arnold H. Glasgow",
      quote:
          "A true friend never gets in your way unless you happen to be going down.",
    ),
    quoteModel(
      author: "Henry David Thoreau",
      quote:
          "Friends…they cherish one another’s hopes. They are kind to one another’s dreams.",
    ),
    quoteModel(
      author: "Patrick Lindsay",
      quote: "Every new friend is a new adventure… the start of more memories.",
    ),
    quoteModel(
      author: "Ann Kaiser Stearns",
      quote: "The kindest way of helping yourself is to find a friend.",
    ),
    quoteModel(
      author: "Kahlil Gibran",
      quote:
          "A friend who is far away is sometimes much nearer than one who is at hand.",
    ),
    quoteModel(
      author: "Ethel Barrymore",
      quote: "The best time to make friends is before you need them.",
    ),
    quoteModel(
      author: "Len Wein",
      quote:
          "A true friend is someone who is there for you when he’d rather be anywhere else.",
    ),
  ];
  List<quoteModel> get fetchQuotesList {
    return [...quotes];
  }
}
