async function extractTextFromImage(imageUrl) {
    const { Tesseract } = window;
    const result = await Tesseract.recognize(imageUrl, 'eng');
    return result.data.text;
  }
  