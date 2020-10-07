const pay = ()=> {
  Payjp.setPublicKey(process.env.PAYJP_PUBLIC_KEY); //PAY.JPテスト公開鍵
   console.log(process.env.PAYJP_PUBLIC_KEY);
  const form = document.getElementById("charge-form");
  form.addEventListener("submit", (e) => {
    e.preventDefault();
    const formResult = document.getElementById("charge-form");
    const formData = new FormData(formResult);
    const card = {
      number: formData.get("order_address[number]"),//検証ツールでname属性確認
      cvc: formData.get("order_address[cvc]"),//検証ツールでname属性確認
      exp_month: formData.get("order_address[exp_month]"),//検証ツールでname属性確認
      exp_year: `20${formData.get("order_address[exp_year]")}`,//検証ツールでname属性確認
    };
    Payjp.createToken(card, (status, response) => {
      console.log(status);
      console.log(response);

      if (status == 200) {
        const token = response.id;
        const renderDom = document.getElementById("charge-form");
        const tokenObj = `<input value=${token} type="hidden" name="token">`;
        renderDom.insertAdjacentHTML("beforeend", tokenObj);
      }
      document.getElementById("card-number").removeAttribute("name");
      document.getElementById("card-cvc").removeAttribute("name");
      document.getElementById("card-exp-month").removeAttribute("name");
      document.getElementById("card-exp-year").removeAttribute("name");

      document.getElementById("charge-form").submit();  
      document.getElementById("charge-form").reset();
    })
  })
}

window.addEventListener("load", pay);