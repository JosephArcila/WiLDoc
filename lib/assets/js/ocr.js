async function extractTextFromImage(imageUrl) {
    const { Tesseract } = window;
    const result = await Tesseract.recognize(imageUrl, 'jpn');
    return result.data.text;
  }
  