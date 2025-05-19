window.addEventListener('message', function(event) {
    let data = event.data;
    if (data.action === "open") {
        document.getElementById('scoreboard').classList.remove('hidden');
        let tbody = document.getElementById('scoreboard-body');
        tbody.innerHTML = "";
        let rank = 1;
        for (const [identifier, stats] of Object.entries(data.players)) {
            let ratio = stats.deaths === 0 ? stats.kills : (stats.kills / stats.deaths);
            let tr = document.createElement('tr');
            tr.innerHTML = `
                <td>${rank}</td>
                <td>${identifier}</td>
                <td>${stats.kills}</td>
                <td>${stats.deaths}</td>
                <td>${ratio.toFixed(2)}</td>
            `;
            tbody.appendChild(tr);
            rank++;
        }
    }
    if (data.action === "close") {
        document.getElementById('scoreboard').classList.add('hidden');
    }
});
