// =========================================================
// My AWS Cloud Journey - small client-side script
// This JavaScript runs in the VISITOR'S BROWSER, not on AWS.
// S3 and CloudFront only store and deliver this file;
// they never execute it. That is what makes the site "static".
// =========================================================

document.addEventListener("DOMContentLoaded", function () {
  // 1. Put the current year in the footer.
  document.getElementById("year").textContent = new Date().getFullYear();

  // 2. Show the visitor's local time when the page loaded.
  document.getElementById("load-time").textContent = new Date().toLocaleString();

  // 3. A tiny interactive button to prove JavaScript was delivered correctly.
  var button = document.getElementById("greet-btn");
  var message = document.getElementById("greet-msg");
  var clicks = 0;

  button.addEventListener("click", function () {
    clicks += 1;
    message.textContent =
      "Hello! This message was produced by JavaScript running in your browser. Clicks: " + clicks;
  });
});
