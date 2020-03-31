<?php
//------------------------------------------------------------------------------
//----------Парсим приличный обьем данных (параметров продуктов питания)--------
//----------Для примера берем сайт https://health-diet.ru/table_calorie/--------
//------------------------------------------------------------------------------
require_once "./simplehtmldom_1_9_1/simple_html_dom.php";
require 'connect.php';
require 'sqlHelper.php';

//Получаем обьект страницы для дальнейшей работы с ней
$data = file_get_html('ссылка на сайт');

$srcs = array();
//Из основной таблицы получаем ссылки на категории
if($data->innertext!='' and count($data->find('div .uk-grid'))){
    //Ходим по блокам
        foreach ($data->find('div .uk-width-large-1-2') as $table) {
            $table = str_get_html($table);
        //Ходим по столбцам блоков
            foreach ($table->find('div .mzr-tc-group-item') as $line) {
                $line = str_get_html($line);
                $link = $line->find('a');
                //Записываем ссылку в асоциативный массив
                //Формата Категория --> ссылка
                $srcs[$link[0]->innertext] = 'ссылка на сайт'.$link[0]->href;
            }
        }
}
startParse($srcs);

//Функция обрабатывающая массив ссылок 
function startParse($srcs){
    $count = 0;

    foreach ($srcs as $name => $link) {
            try {
                //Получаем контекст по ссылке
                $data = file_get_html($link);
                //Вошли в таблицу
                foreach ($data->find('table.uk-table') as $table) {
                    $countInTable = 0;
                    //Бегаем по всем тегам 'td' и в if ах раскидываем их 
                    //на поля таблицы формируя строчку данных
                    foreach ($table->find('td') as $tr) {
                        $tr = str_get_html($tr);
                        if($countInTable == 0){
                            $linkTable = $tr->find('a');
                            $nameprod = $linkTable[0]->innertext;
                        }
                        else if($countInTable == 1){
                            $calories = $tr->innertext;
                        }
                        else if($countInTable == 2){
                            $squi = $tr->innertext;
                        }
                        else if($countInTable == 3){
                            $fats = $tr->innertext;
                        }
                        else if($countInTable == 4){
                            $carboh = $tr->innertext;
                            $countInTable = -1;
                            //Закидываем строку данных в файл
                            $s = fopen("calory-data.txt","a+");
                                fwrite($s,'"'.$name.';'.$nameprod.';'.$calories.';'.$squi.';'.$fats.';'.$carboh.'",'."\r\n");
                                fclose($s);
                            $count++;
                        }
                        $countInTable++;
                    }
                }
            //Если ссылка не действительная выбрасываем исключение и работаем дальше 
            } catch (\Throwable $th) {
                echo $th;
            }
    }
    echo "Я запарсил  <strong>" . $count. "</strong>  записей";
}

?>