<?php

namespace Admin;

use Zend\ModuleManager\Feature\AutoloaderProviderInterface;
use Zend\ModuleManager\Feature\ConfigProviderInterface;
// Add these import statements:
use Smeagol\Model\Node;
use Smeagol\Model\NodeTable;
use Smeagol\Model\User;
use Smeagol\Model\UserTable;
use Smeagol\Model\Menu;
use Smeagol\Model\MenuTable;
use Admin\Model\Page;
use Admin\Model\Noticia;
use Zend\Db\ResultSet\ResultSet;
use Zend\Db\TableGateway\TableGateway;

class Module implements AutoloaderProviderInterface, ConfigProviderInterface {
 public function getAutoloaderConfig()
    {
        return array(
            'Zend\Loader\ClassMapAutoloader' => array(
                __DIR__ . '/autoload_classmap.php',
            ),
            'Zend\Loader\StandardAutoloader' => array(
                'namespaces' => array(
                    __NAMESPACE__ => __DIR__ . '/src/' . __NAMESPACE__,
                   "Smeagol" => __DIR__ . '/../../model/src/Smeagol',
                ),
            ),
        );
    }

    public function getConfig()
    {
        return include __DIR__ . '/config/module.config.php';
    }
	
    public function getServiceConfig()
    {
	return array(
		'factories' => array(
				'Smeagol\Model\NodeTable' =>  function($sm) {
					$tableGateway = $sm->get('NodeTableGateway');
					$table = new NodeTable($tableGateway);
					return $table;
				},
                                'Smeagol\Model\MenuTable' => function($sm) {
                                        $tableGateway = $sm->get('MenuTableGateway');
                                        $table = new MenuTable($tableGateway);
                                        return $table;
                                },
                                'MenuTableGateway' => function ($sm) {
                                        $dbAdapter = $sm->get('Zend\Db\Adapter\Adapter');
                                        $resultSetPrototype = new ResultSet();
                                        $resultSetPrototype->setArrayObjectPrototype(new Menu());
                                        return new TableGateway('menu', $dbAdapter, null, $resultSetPrototype);
                                },
                                'NodeTableGateway' => function ($sm) {
					$dbAdapter = $sm->get('Zend\Db\Adapter\Adapter');
					$resultSetPrototype = new ResultSet();
					$resultSetPrototype->setArrayObjectPrototype(new Node());
					return new TableGateway('node', $dbAdapter, null, $resultSetPrototype);
				},
				'Admin\Model\Page' =>  function($sm) {
					$tableGateway = $sm->get('NodeTableGateway');
					$table = new Page($tableGateway);
					return $table;
				},
				'Admin\Model\Noticia' =>  function($sm) {
					$tableGateway = $sm->get('NodeTableGateway');
					$table = new Noticia($tableGateway);
					return $table;
				},
		),
	);
    }
}