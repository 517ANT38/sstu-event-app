// Функция для получения данных с сервера
const options = {
    year: 'numeric',
    month: 'long',
    day: 'numeric',
    weekday: 'long',
    timezone: 'UTC',
    hour: 'numeric',
    minute: 'numeric',
    second: 'numeric'
  };
async function fetchData() {
    try {
        const response = await fetch('http://localhost:8080/api/requestsEvents');
        const data = await response.json();
        renderTable(data);
    } catch (error) {
        console.error("Error fetching data:", error);
    }
}

function hex2bin(hex)
{
    var bytes = [], str;

    for(var i=0; i< hex.length-1; i+=2)
        bytes.push(parseInt(hex.substr(i, 2), 16));

    return String.fromCharCode.apply(String, bytes);
}

function alertDecodeIdEvent(data) {
    let [ url, date] = hex2bin(data).split('_');

    showAlert(url,new Date(date).toLocaleString('ru'))

}

// Функция для отображения данных в таблице
function renderTable(data) {
    const tableBody = document.querySelector('#data-table tbody');
    tableBody.innerHTML = ''; // Очистить таблицу


    data.forEach(item => {
        const row = document.createElement('tr');
        console.log(item)
        row.innerHTML = `
            <td style='cursor: pointer;' onclick='alertDecodeIdEvent("${item.idEvent}")'>${item.idEvent.slice(0,5)}</td>
            <td>${item.secondName} ${item.firstName} ${item.middleName??''}</td>
            <td>${item.edu}</td>
            <td>${item.phone}</td>
            <td>${item.countChild}</td>
            <td>${item.fromClass}</td>
            <td>${item.toClass}</td>
            <td>${new Date(item.created_at).toLocaleString('ru',options)}</td>
        `;
        tableBody.appendChild(row);
    });
}
function showAlert(url, date) {
    const alertBox = document.getElementById('alert-box');
    const alertUrl = document.getElementById('alert-url');
    const alertDate = document.getElementById('alert-date');

    alertUrl.textContent = `URL: ${url}`;
    alertDate.textContent = `Дата и время создания мероприятия: ${date}`;
    alertBox.style.display = 'flex';
}
function hideAlert() {
    const alertBox = document.getElementById('alert-box');
    alertBox.style.display = 'none';
}
document.getElementById('close-alert').addEventListener('click', hideAlert);
// Автоматический запрос каждые 15 минут
setInterval(fetchData, 900000); // 15 минут в миллисекундах

// Первый запуск
fetchData();
