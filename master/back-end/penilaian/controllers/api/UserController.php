<?php

namespace app\controllers\api;

use app\models\MasterUsers;
use Yii;
use yii\data\SqlDataProvider;

class UserController extends \yii\web\Controller
{

    public function actionGetallusers()
    {
        // $masterUser = MasterUsers::find()->all();
        $sql = "SELECT * FROM master_users";
        $item = new SqlDataProvider([
            'sql' => $sql,
            'db' => 'db',
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        // return $masterUser;
        return $model;
    }

    public function actionGettelpuser($id)
    {
        $sql = "SELECT b.no_telp FROM master_users as a, master_telp as b where a.id = b.id_user and a.id = '$id'";
        $item = new SqlDataProvider([
            'sql' => $sql,
            'db' => 'db',
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        return $model;
    }

    public function actionGetnewdb()
    {
        $db = new yii\db\Connection([
            'dsn' => 'mysql:host=localhost;port=3308;dbname=iot',
            'username' => 'root',
            'password' => '',
            'charset' => 'utf8',
        ]);

        $db->open();

        $sql = "SELECT * FROM user a";
        $item = new SqlDataProvider([
            'sql' => $sql,
            'db' => $db,
        ]);
        $item->pagination = FALSE;
        $model = $item->getModels();
        Yii::$app->response->format = \yii\web\Response::FORMAT_JSON;
        return $model;
    }
}
