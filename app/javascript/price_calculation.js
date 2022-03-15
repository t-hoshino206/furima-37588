window.addEventListener('load', () => {
  const priceInput = document.getElementById("item-price");
  priceInput.addEventListener("input", () => {
    const inputValue = priceInput.value;
    console.log(inputValue);

    // 販売手数料10%を表示する
    const tax = Math.floor(inputValue * 0.1)
    const addTaxDom = document.getElementById("add-tax-price");
    addTaxDom.innerHTML = tax

    // 販売利益を表示する
    const profitDom = document.getElementById("profit");
    profitDom.innerHTML = Math.floor(inputValue - tax)
  })
});