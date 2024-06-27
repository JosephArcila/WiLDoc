async function extractTextFromImage(imageDataUrl) {
  const { Tesseract } = window;
  const result = await Tesseract.recognize(imageDataUrl, 'jpn');
  return result.data.text;
}