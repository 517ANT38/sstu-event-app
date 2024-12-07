# sstu-event-app

### Для сборки
```make build```
### Для запуска выполните две команды
```make up```  
```make install-or-update-deps```
### Перез загрузкой новостей и мероприятий обучить и провалидируете модель  
> Предварительно, в директорию ml_api/storage/app положите папки test и train, каждая с подпапками negative, positive. После обучения в  создадуться директории reports для отчетов об обучение или валидации и файл модели в папке ml_api/storage/app .

> Обучим модель
```make train-ml```  
> Провалидируем модель ```validate-ml```

> После обучения создаться файл отчета report.json в директории ml_api/storage/app/reports. 

### Для загрузки новостей в redis
```make init-data```