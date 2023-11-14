  document.addEventListener("turbo:load", function() {
    const switchLinks = document.querySelectorAll('.switch-ranking');
    const rankingContainers = {
      bookmark: document.getElementById('bookmarkRanks'),
      comment: document.getElementById('commentRanks'),
      diagnosis: document.getElementById('diagnosisRanks'),
    };

    switchLinks.forEach(link => {
      link.addEventListener('click', function(event) {
        event.preventDefault();
        const target = this.getAttribute('data-target');

        // 選択されたリンクに応じて対応するランキングを表示
        for (const key in rankingContainers) {
          if (key === target) {
            rankingContainers[key].style.display = 'block';
          } else {
            rankingContainers[key].style.display = 'none';
          }
        }
      });

      // 最初は全てのランキングを非表示にする
    });
  });
