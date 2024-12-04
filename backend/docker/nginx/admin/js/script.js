// Функция для получения данных с сервера
let obj = {

    "secondName": "Ant",
    "firstName": "Ant",
    "middleName": "Ant",
    "edu": "edu",
    "phone": "89378031774",
    "countChild": 9,
    "fromClass": 10,
    "toClass": 11,
    "idEvent": "68747470733a2f2f7777772e737374752e72752f6e6577732f706f6c6974656b682d6f7267616e697a6f76616c2d70726f666573696f6e616c6e79652d70726f62792d646c79612d656e67656c73736b696b682d73686b6f6c6e696b6f762e68746d6c5f323032342d31322d30335432313a32353a30392b30333a3030",
}

async function fetchData() {
    try {
        const response = await fetch('/api/requestsEvents');
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
    let options = {
        year: 'numeric',
        month: 'long',
        day: 'numeric',
        weekday: 'long',
        timezone: 'UTC',
        hour: 'numeric',
        minute: 'numeric',
        second: 'numeric'
      };
    showAlert(url,new Date(date).toLocaleString('ru'))

}

// Функция для отображения данных в таблице
function renderTable(data) {
    const tableBody = document.querySelector('#data-table tbody');
    tableBody.innerHTML = ''; // Очистить таблицу


    data.forEach(item => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td style='cursor: pointer;' onclick='alertDecodeIdEvent("${item.idEvent}")'>${item.idEvent.slice(0,10)}</td>
            <td>${item.secondName} ${item.firstName} ${item.middleName??''}</td>
            <td>${item.edu}</td>
            <td>${item.phone}</td>
            <td>${item.countChild}</td>
            <td>${item.fromClass}</td>
            <td>${item.toClass}</td>
        `;
        tableBody.appendChild(row);
    });
}
function showAlert(url, date) {
    const alertBox = document.getElementById('alert-box');
    const alertUrl = document.getElementById('alert-url');
    const alertDate = document.getElementById('alert-date');

    alertUrl.textContent = `URL: ${url}`;
    alertDate.textContent = `Дата и время создания: ${date}`;
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
