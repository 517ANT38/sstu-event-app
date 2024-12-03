// Функция для получения данных с сервера
async function fetchData() {
    try {
        const response = await fetch('/api/requestsEvents');
        console.log(response)
        // const data = await response.json();
        renderTable([{id:1,name:'Name1',age:11},{id:2,name:'Name2',age:12},{id:3,name:'Name3',age:13}]);
    } catch (error) {
        console.error("Error fetching data:", error);
    }
}

// Функция для отображения данных в таблице
function renderTable(data) {
    const tableBody = document.querySelector('#data-table tbody');
    tableBody.innerHTML = ''; // Очистить таблицу

    data.forEach(item => {
        const row = document.createElement('tr');
        row.innerHTML = `
            <td>${item.id}</td>
            <td>${item.name}</td>
            <td>${item.age}</td>
        `;
        tableBody.appendChild(row);
    });
}

// Автоматический запрос каждые 15 минут
setInterval(fetchData, 900000); // 15 минут в миллисекундах

// Первый запуск
fetchData();
