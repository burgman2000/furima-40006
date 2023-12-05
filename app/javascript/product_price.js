window.addEventListener('turbo:load', () => {
  const priceInput = document.getElementById("item-price");
  const addTaxPriceElement = document.getElementById('add-tax-price');
  const profitElement = document.getElementById('profit');
  

  priceInput.addEventListener("input", () => {
    updateDisplay();
  });

  function updateDisplay() {
    const inputValue = priceInput.value.trim();

    // 価格が空の場合は表示をクリア
    if (!inputValue) {
      clearDisplay();
      return;
    }

    // 入力された価格が数字でない場合は表示をクリア
    if (isNaN(inputValue)) {
      clearDisplay();
      return;
    }

    // 価格を数値に変換
    const price = parseFloat(inputValue);

    // 販売手数料を計算 (10%)
    const salesCommission = Math.floor(price * 0.1);

    // 販売利益を計算
    const profit = price - salesCommission;

    // 販売手数料と販売利益を表示
    addTaxPriceElement.textContent = `${salesCommission}`;
    profitElement.textContent = `${Math.floor(profit)}`;
  }

  function clearDisplay() {
    // 値を0円で表示
    addTaxPriceElement.textContent = '';
    profitElement.textContent = '';
  }


  // 初回表示
  updateDisplay();
});