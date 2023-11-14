document.addEventListener('turbo:load', function () {
  // ここにJavaScriptコードを配置
  const switchRankingLinks = document.querySelectorAll('.switch-ranking');

  switchRankingLinks.forEach(function (link) {
    link.addEventListener('click', function () {
      const targetId = link.getAttribute('data-target');
      const allRankings = document.querySelectorAll('.blind');

      allRankings.forEach(function (ranking) {
        ranking.style.display = 'none';
      });

      const targetRanking = document.querySelector(targetId);
      targetRanking.style.display = 'block';
      console.log(targetRanking)
    });
  });
});
