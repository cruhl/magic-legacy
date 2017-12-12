const start = 1512880850000;
const end = start + 53 * 1000;

module.exports = data => {
  const { results, speaker_labels } = data;
  const alternatives = results.map(
    ({ alternatives: [alternative] }) => alternative
  );

  const transcriptionAndWords = alternatives.map(
    alternativeToTranscriptionAndWords
  );

  let words = [];
  const transcriptions = transcriptionAndWords.map(
    ([transcription, wordsFromTranscription]) => {
      wordsFromTranscription.forEach(word => words.push(word));
      return transcription;
    }
  );

  return {
    audio: [
      {
        timing: { start, end },
        uri: "2017-12-10T04:40:53.000Z.wav"
      }
    ],
    transcriptions,
    words,
    speakers: speaker_labels.map(speakerLabelsToSpeakers)
  };
};

const alternativeToTranscriptionAndWords = ({
  transcript,
  confidence,
  word_confidence,
  timestamps
}) => {
  const words = timestamps.map(timestampToWord(word_confidence));
  return [
    {
      timing: {
        start: words[0].timing.start,
        end: words[words.length - 1].timing.end
      },
      transcript,
      confidence
    },
    timestamps.map(timestampToWord(word_confidence))
  ];
};

const timestampToWord = word_confidence => ([text, wordStart, wordEnd], i) => {
  const [_, confidence] = word_confidence[i];
  return {
    timing: {
      start: start + wordStart * 1000,
      end: start + wordEnd * 1000
    },
    text,
    confidence
  };
};

const speakerLabelsToSpeakers = ({ from, to, speaker, confidence }) => ({
  timing: {
    start: start + from * 1000,
    end: start + to * 1000
  },
  index: speaker,
  confidence
});
