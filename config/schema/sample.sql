-- http://localhost:8080/editor/index-debug.html?contextId=7370331a-3ca2-427d-94d7-5d34f322683e
-- http://localhost:8822/lifia/es/rossi.htm

USE `actions`;

INSERT INTO `user`(`user_id`, `first_name`, `last_name`) VALUES(1, 'Matias', 'Rivero');
INSERT INTO `user`(`user_id`, `first_name`, `last_name`) VALUES(2, 'Esteban', 'Robles Luna');

INSERT INTO `team`(`team_id`, `name`, `owner_id`) VALUES(1, 'Magic duo', 1);

INSERT INTO `user_team`(`team_id`, `user_id`) VALUES(1, 1);
INSERT INTO `user_team`(`team_id`, `user_id`) VALUES(1, 2);

INSERT INTO `application`(`application_id`, `name`, `team_id`) VALUES(1, 'Engaged.ly', 1);
INSERT INTO `application`(`application_id`, `name`, `team_id`) VALUES(2, 'LIFIA site', 1);

INSERT INTO `flows`(`flow_id`,`name`,`application_id`,`json_representation`) VALUES (1, '7370331a-3ca2-427d-94d7-5d34f322683e', 2, '{"id":"7370331a-3ca2-427d-94d7-5d34f322683e","version":1,"definitions":[{"id":"f247492d-78d1-41c9-a83c-aae4bea8acfd","name":"GROOVY","properties":{"_breakpoint":false,"name":"Publications info","x":"311","y":"472","script":"message.payload = \'{\\\"publications\\\":[{\\\"authors\\\":\\\"Santiago Robles, Juan Lautaro Fern??ndez, Andres Fortier, Gustavo Rossi, Silvia E. Gordillo.\\\",\\\"title\\\":\\\"Improving the model view controller paradigm in the web.\\\",\\\"conference\\\":\\\"Int. J. Web Eng. Technol. 7(1): 22-44 (2012).\\\"},{\\\"authors\\\":\\\"Gustavo Rossi, San Murugesan, Nina Godbole.\\\",\\\"title\\\":\\\"IT in Emerging Markets.\\\",\\\"conference\\\":\\\"IT Professional 14(4): 2-3 (2012).\\\"},{\\\"authors\\\":\\\"Mario Matias Urbieta, Gustavo Rossi, Silvia E. Gordillo, Wieland Schwinger, Werner Retschitzegger, Mar??a Jos?? Escalona Cuaresma.\\\",\\\"title\\\":\\\"Identifying and Modelling Complex Workflow Requirements in Web Applications.\\\",\\\"conference\\\":\\\"ICWE Workshops 2012: 146-157.\\\"}]}\'"}},{"id":"e3c342b9-b600-412c-b748-7796a568f870","name":"HTTP_FETCHER","properties":{"fetchMode":"GET","urlExpression":"\'http:\/\/localhost:8833\/publications\'","_breakpoint":false,"name":"HTTP fetch publications","x":"559","y":"212","streaming":"false"}},{"id":"6a795824-7cf3-42d3-bf25-4e2c311d77b6","name":"DUST_RENDERER","properties":{"template":"\'\'","templateName":"\'profile\'","_breakpoint":false,"name":"Dust renderer","x":"557","jsonData":"message.payload","y":"338"}},{"id":"3f409e26-32bb-4cd7-a3ac-db2aa6f56b44","name":"GROOVY","properties":{"_breakpoint":false,"name":"Profile info","x":"443","y":"474","script":"message.payload = \'{\\\"firstName\\\":\\\"Gustavo\\\",\\\"lastName\\\":\\\"Rossi\\\",\\\"position\\\":\\\"Investigador\\\",\\\"address\\\":\\\"Lifia, calle 50 y 115, La Plata, Prov. Buenos Aires, Argentina\\\",\\\"phone\\\":\\\"(+54 221) 423 6585 ext 213\\\",\\\"fax\\\":\\\"(+54 221) 422 8252\\\"}\'"}},{"id":"4a46fa35-b525-4646-8e36-5bc874d73c9e","name":"ALL","properties":{"__next_in_chain":"urn:673a8624-28d2-4998-8be2-72fd67ca7f66","_breakpoint":false,"name":"Fetch gustavo info","x":"439","y":"173","__connectionsALL_CONNECTION":"list(urn:9d8476be-d27a-41cf-9f81-6aa0226f651d,urn:e144e010-28f2-4646-abd5-56c31a4b5bbb)"}},{"id":"f0713257-6b3a-4433-84f6-934b0cbe94ae","name":"LOG","properties":{"toLogExpression":"\'[INCOMING TRAFFIC] to: \' + message.properties[\'actions.http.requestURI\']","name":"Log","x":"293","y":"332","logName":"incomingTraffic","_breakpoint":false}},{"id":"ec9f8f9b-cd30-4cb1-8619-711873afe856","name":"GROOVY","properties":{"_breakpoint":false,"name":"Pagina matias","x":"495","y":"88","script":"message.payload = \'Matias\'"}},{"id":"250c730b-0b5e-4236-a0a9-f262447809ce","name":"FILE_READER","properties":{"filePath":"message.properties[\'actions.http.requestURI\'].replaceAll(\'\/people\/\', \'\/\')","_breakpoint":false,"name":"File reader","x":"358","y":"206","directory":"\'\/Users\/estebanroblesluna\/Downloads\/lifia\/es\'"}},{"id":"f5642575-af3a-4166-b6e1-526037ab0a55","name":"GROOVY","properties":{"__next_in_chain":"urn:0cd18b43-3e54-42ce-915c-1236538b5a51","_breakpoint":true,"name":"Merge json","x":"489","y":"282","script":"message.payload = \'{ \\\"profile\\\" : \' + message.properties[\'profileJson\'] + \', \\\"publications\\\": \' + message.properties[\'publicationsJson\'] + \'}\'"}},{"id":"927b3eea-82ff-4774-a89d-f536a8fda390","name":"HTTP_FETCHER","properties":{"fetchMode":"GET","urlExpression":"\'http:\/\/localhost:8833\/profile\'","_breakpoint":false,"name":"HTTP fetch profile","x":"580","y":"132","streaming":"false"}},{"id":"9e24bbef-69ad-478e-9864-eb70b27a194f","name":"HTTP_MESSAGE_SOURCE","properties":{"__next_in_chain":"urn:aac61b2c-272b-45b1-9cc9-052d72de0f36","port":"8833","__connectionsNEXT_IN_CHAIN_CONNECTION":"list(null,urn:aac61b2c-272b-45b1-9cc9-052d72de0f36)","_breakpoint":false,"name":"Backend entry point","x":"39","y":"313"}},{"id":"502754a7-cd66-4dee-a12f-09db8cde0cfe","name":"HTTP_MESSAGE_SOURCE","properties":{"__next_in_chain":"urn:31625e48-da0f-40dd-9179-f99f479a8143","port":"8822","timeoutExpression":"return 0l;","_breakpoint":false,"name":"Frontend entry point","x":"138","y":"97"}},{"id":"034eaeae-bb72-4bd0-80a8-bd8e98153782","name":"CHOICE","properties":{"__connectionsCHOICE_CONNECTION":"list(urn:619acdb2-fff6-4160-9a36-d16bb16fb986,urn:26662a2f-0327-40af-9f44-f9f87449db99,urn:8203c333-a472-4954-9d33-f0d39df86a80,urn:c917b54b-db35-4431-a8e5-0f89d71106ea,urn:8f66e119-7ab3-47fe-a288-9f0ac0e0f8b7,urn:0c4f9da2-fd9c-4f2a-82b7-4170d9e43218)","_breakpoint":false,"name":"Path router","x":"348","y":"93"}},{"id":"57ed021a-ad36-433e-ad91-d17e5def0f61","name":"FILE_READER","properties":{"filePath":"message.properties[\'actions.http.requestURI\'].replaceAll(\'\/lifia\/\', \'\/\')","_breakpoint":false,"name":"Sitio viejo del lifia","x":"449","y":"21","directory":"\'\/Users\/estebanroblesluna\/Downloads\/lifia\'"}},{"id":"1db71c62-d1e4-45a1-a498-502e7c717e62","name":"WIRE_TAP","properties":{"__next_in_chain":"urn:504e1613-83a1-4cd8-8dcd-6b1d92803ca7","__connectionsNEXT_IN_CHAIN_CONNECTION":"list(urn:504e1613-83a1-4cd8-8dcd-6b1d92803ca7)","__connectionsWIRE_TAP_CONNECTION":"list(urn:35c99368-9ca7-48d3-8908-b783db8f5341)","name":"Wire tap","x":"246","y":"382","_breakpoint":false}},{"id":"48f1c351-438a-4709-b1f5-0dbcb90e1810","name":"CHOICE","properties":{"__connectionsCHOICE_CONNECTION":"list(urn:0efc770f-ed1b-49b9-913b-08fa8829e375,urn:2c488a92-becc-4cbc-b4be-686f25a6b5e7)","_breakpoint":false,"name":"Path router","x":"367","y":"419"}},{"id":"aac61b2c-272b-45b1-9cc9-052d72de0f36","name":"NEXT_IN_CHAIN_CONNECTION","properties":{"points":"134,335;254,382;","source":"urn:9e24bbef-69ad-478e-9864-eb70b27a194f","target":"urn:1db71c62-d1e4-45a1-a498-502e7c717e62","type":"NEXT_IN_CHAIN_CONNECTION","_breakpoint":false}},{"id":"0c4f9da2-fd9c-4f2a-82b7-4170d9e43218","name":"CHOICE_CONNECTION","properties":{"points":"392,115;400,206;","expression":"message.properties[\'actions.http.requestURI\'].startsWith(\'\/people\/\')","source":"urn:034eaeae-bb72-4bd0-80a8-bd8e98153782","_breakpoint":false,"target":"urn:250c730b-0b5e-4236-a0a9-f262447809ce"}},{"id":"0cd18b43-3e54-42ce-915c-1236538b5a51","name":"NEXT_IN_CHAIN_CONNECTION","properties":{"points":"547,304;593,338;","source":"urn:f5642575-af3a-4166-b6e1-526037ab0a55","_breakpoint":false,"target":"urn:6a795824-7cf3-42d3-bf25-4e2c311d77b6"}},{"id":"8f66e119-7ab3-47fe-a288-9f0ac0e0f8b7","name":"CHOICE_CONNECTION","properties":{"points":"406,115;486,173;","expression":"message.properties[\'actions.http.requestURI\'] == \'\/people\/gustavo\'","source":"urn:034eaeae-bb72-4bd0-80a8-bd8e98153782","_breakpoint":false,"target":"urn:4a46fa35-b525-4646-8e36-5bc874d73c9e"}},{"id":"9d8476be-d27a-41cf-9f81-6aa0226f651d","name":"ALL_CONNECTION","properties":{"points":"539,173;604,154;","source":"urn:4a46fa35-b525-4646-8e36-5bc874d73c9e","_breakpoint":false,"targetExpression":"message.properties[\'profileJson\'] = result.payload","target":"urn:927b3eea-82ff-4774-a89d-f536a8fda390"}},{"id":"8203c333-a472-4954-9d33-f0d39df86a80","name":"CHOICE_CONNECTION","properties":{"points":"409,93;491,43;","expression":"message.properties[\'actions.http.requestURI\'].startsWith(\'\/lifia\/\')","source":"urn:034eaeae-bb72-4bd0-80a8-bd8e98153782","_breakpoint":false,"target":"urn:57ed021a-ad36-433e-ad91-d17e5def0f61"}},{"id":"35c99368-9ca7-48d3-8908-b783db8f5341","name":"WIRE_TAP_CONNECTION","properties":{"points":"289,382;309,354;","source":"urn:1db71c62-d1e4-45a1-a498-502e7c717e62","target":"urn:f0713257-6b3a-4433-84f6-934b0cbe94ae","type":"WIRE_TAP_CONNECTION","_breakpoint":false}},{"id":"504e1613-83a1-4cd8-8dcd-6b1d92803ca7","name":"NEXT_IN_CHAIN_CONNECTION","properties":{"points":"317,403;372,419;","source":"urn:1db71c62-d1e4-45a1-a498-502e7c717e62","target":"urn:48f1c351-438a-4709-b1f5-0dbcb90e1810","type":"NEXT_IN_CHAIN_CONNECTION","_breakpoint":false}},{"id":"0efc770f-ed1b-49b9-913b-08fa8829e375","name":"CHOICE_CONNECTION","properties":{"points":"425,441;470,474;","expression":"message.properties[\'actions.http.requestURI\'] == \'\/profile\'","source":"urn:48f1c351-438a-4709-b1f5-0dbcb90e1810","_breakpoint":false,"target":"urn:3f409e26-32bb-4cd7-a3ac-db2aa6f56b44"}},{"id":"673a8624-28d2-4998-8be2-72fd67ca7f66","name":"NEXT_IN_CHAIN_CONNECTION","properties":{"points":"505,195;529,282;","source":"urn:4a46fa35-b525-4646-8e36-5bc874d73c9e","_breakpoint":false,"target":"urn:f5642575-af3a-4166-b6e1-526037ab0a55"}},{"id":"31625e48-da0f-40dd-9179-f99f479a8143","name":"NEXT_IN_CHAIN_CONNECTION","properties":{"points":"273,107;348,105;","source":"urn:502754a7-cd66-4dee-a12f-09db8cde0cfe","_breakpoint":false,"target":"urn:034eaeae-bb72-4bd0-80a8-bd8e98153782"}},{"id":"e144e010-28f2-4646-abd5-56c31a4b5bbb","name":"ALL_CONNECTION","properties":{"points":"540,195;598,212;","source":"urn:4a46fa35-b525-4646-8e36-5bc874d73c9e","_breakpoint":false,"targetExpression":"message.properties[\'publicationsJson\'] = result.payload","target":"urn:e3c342b9-b600-412c-b748-7796a568f870"}},{"id":"26662a2f-0327-40af-9f44-f9f87449db99","name":"CHOICE_CONNECTION","properties":{"points":"434,103;495,101;","expression":"message.properties[\'actions.http.requestURI\'] == \'\/people\/murbieta\'","source":"urn:034eaeae-bb72-4bd0-80a8-bd8e98153782","_breakpoint":false,"target":"urn:ec9f8f9b-cd30-4cb1-8619-711873afe856"}},{"id":"2c488a92-becc-4cbc-b4be-686f25a6b5e7","name":"CHOICE_CONNECTION","properties":{"points":"401,441;378,472;","expression":"message.properties[\'actions.http.requestURI\'] == \'\/publications\'","source":"urn:48f1c351-438a-4709-b1f5-0dbcb90e1810","_breakpoint":false,"target":"urn:f247492d-78d1-41c9-a83c-aae4bea8acfd"}}]}');


INSERT INTO `library` (`library_id`, `name`, `display_name`) VALUES (1,'common','Common');
INSERT INTO `library` (`library_id`, `name`, `display_name`) VALUES (2,'modules','Modules');



INSERT INTO `element_definition` (`element_definition_id`, `name`, `display_name`, `icon`, `implementation`, `library_id`, `is_script`) VALUES (1,'GROOVY','Groovy','Resources/groovy.gif','com.common.expression.ScriptingProcessor',1,0);
INSERT INTO `element_definition` (`element_definition_id`, `name`, `display_name`, `icon`, `implementation`, `library_id`, `is_script`) VALUES (2,'NEXT_IN_CHAIN_CONNECTION','Next in chain connection','Resources/nextInChainConnection.png','com.core.impl.NextInChainConnection',1,0);
INSERT INTO `element_definition` (`element_definition_id`, `name`, `display_name`, `icon`, `implementation`, `library_id`, `is_script`) VALUES (3,'CHOICE','Choice router','Resources/groovy.gif','com.core.routing.ChoiceRouter',1,0);
INSERT INTO `element_definition` (`element_definition_id`, `name`, `display_name`, `icon`, `implementation`, `library_id`, `is_script`) VALUES (4,'CHOICE_CONNECTION','Choice connection','Resources/choiceConnection.png','com.core.impl.ChoiceConnection',1,0);
INSERT INTO `element_definition` (`element_definition_id`, `name`, `display_name`, `icon`, `implementation`, `library_id`, `is_script`) VALUES (5,'ALL','All router','Resources/groovy.gif','com.core.routing.AllRouter',1,0);
INSERT INTO `element_definition` (`element_definition_id`, `name`, `display_name`, `icon`, `implementation`, `library_id`, `is_script`) VALUES (6,'ALL_CONNECTION','All connection','Resources/allConnection.png','com.core.impl.AllConnection',1,0);
INSERT INTO `element_definition` (`element_definition_id`, `name`, `display_name`, `icon`, `implementation`, `library_id`, `is_script`) VALUES (7,'WIRE_TAP','Wire tap router','Resources/groovy.gif','com.core.routing.WireTapRouter',1,0);
INSERT INTO `element_definition` (`element_definition_id`, `name`, `display_name`, `icon`, `implementation`, `library_id`, `is_script`) VALUES (8,'WIRE_TAP_CONNECTION','Wire tap connection','Resources/allConnection.png','com.core.impl.WireTapConnection',1,0);
INSERT INTO `element_definition` (`element_definition_id`, `name`, `display_name`, `icon`, `implementation`, `library_id`, `is_script`) VALUES (9,'HTTP_FETCHER','Http fetcher','Resources/groovy.gif','com.modules.http.HttpFetcherProcessor',2,0);
INSERT INTO `element_definition` (`element_definition_id`, `name`, `display_name`, `icon`, `implementation`, `library_id`, `is_script`) VALUES (10,'HTTP_MESSAGE_SOURCE','Http message source','Resources/groovy.gif','com.modules.http.HttpMessageSource',2,0);
INSERT INTO `element_definition` (`element_definition_id`, `name`, `display_name`, `icon`, `implementation`, `library_id`, `is_script`) VALUES (11,'FILE_READER','File reader','Resources/groovy.gif','com.modules.file.FileReaderProcessor',2,0);
INSERT INTO `element_definition` (`element_definition_id`, `name`, `display_name`, `icon`, `implementation`, `library_id`, `is_script`) VALUES (12,'DUST_RENDERER','Dust renderer','Resources/groovy.gif','com.modules.dust.DustRendererProcessor',2,0);
INSERT INTO `element_definition` (`element_definition_id`, `name`, `display_name`, `icon`, `implementation`, `library_id`, `is_script`) VALUES (13,'LOG','Logger','Resources/groovy.gif','com.core.common.LogProcessor',2,0);

INSERT INTO `processor_definition` (`element_definition_id`) VALUES (1);
INSERT INTO `processor_definition` (`element_definition_id`) VALUES (9);
INSERT INTO `processor_definition` (`element_definition_id`) VALUES (11);
INSERT INTO `processor_definition` (`element_definition_id`) VALUES (12);
INSERT INTO `processor_definition` (`element_definition_id`) VALUES (13);

INSERT INTO `connection_definition` (`element_definition_id`, `color`, `accepted_source_types`, `accepted_target_types`, `accepted_source_max`, `accepted_target_max`) VALUES (2,'777777','*','*',1,2147483647);
INSERT INTO `connection_definition` (`element_definition_id`, `color`, `accepted_source_types`, `accepted_target_types`, `accepted_source_max`, `accepted_target_max`) VALUES (4,'0000BB','CHOICE','*',2147483647,2147483647);
INSERT INTO `connection_definition` (`element_definition_id`, `color`, `accepted_source_types`, `accepted_target_types`, `accepted_source_max`, `accepted_target_max`) VALUES (6,'00BB00','ALL','*',2147483647,2147483647);
INSERT INTO `connection_definition` (`element_definition_id`, `color`, `accepted_source_types`, `accepted_target_types`, `accepted_source_max`, `accepted_target_max`) VALUES (8,'AA00BB','WIRE_TAP','*',1,2147483647);

INSERT INTO `message_source_definition` (`element_definition_id`) VALUES (10);

INSERT INTO `router_definition` (`element_definition_id`, `router_evaluator_implementation`, `is_router_evaluator_script`) VALUES (3,'com.core.interpreter.ChoiceRouterEvaluator',0);
INSERT INTO `router_definition` (`element_definition_id`, `router_evaluator_implementation`, `is_router_evaluator_script`) VALUES (5,'com.core.interpreter.AllRouterEvaluator',0);
INSERT INTO `router_definition` (`element_definition_id`, `router_evaluator_implementation`, `is_router_evaluator_script`) VALUES (7,'com.core.interpreter.WireTapRouterEvaluator',0);

INSERT INTO `element_property_definition` (`property_definition_id`, `element_definition_id`, `name`, `display_name`, `property_type`, `default_value`) VALUES (1,1,'name','Name','STRING','New script');
INSERT INTO `element_property_definition` (`property_definition_id`, `element_definition_id`, `name`, `display_name`, `property_type`, `default_value`) VALUES (2,1,'script','Script','STRING','');
INSERT INTO `element_property_definition` (`property_definition_id`, `element_definition_id`, `name`, `display_name`, `property_type`, `default_value`) VALUES (3,2,'name','Name','STRING','New next in chain connection');
INSERT INTO `element_property_definition` (`property_definition_id`, `element_definition_id`, `name`, `display_name`, `property_type`, `default_value`) VALUES (4,3,'name','Name','STRING','New choice router');
INSERT INTO `element_property_definition` (`property_definition_id`, `element_definition_id`, `name`, `display_name`, `property_type`, `default_value`) VALUES (5,4,'name','Name','STRING','New choice connection');
INSERT INTO `element_property_definition` (`property_definition_id`, `element_definition_id`, `name`, `display_name`, `property_type`, `default_value`) VALUES (6,4,'expression','Expression','EXPRESSION','expression:groovy:message.properties[\'name\'] == \'A\'');
INSERT INTO `element_property_definition` (`property_definition_id`, `element_definition_id`, `name`, `display_name`, `property_type`, `default_value`) VALUES (7,5,'name','Name','STRING','New all router');
INSERT INTO `element_property_definition` (`property_definition_id`, `element_definition_id`, `name`, `display_name`, `property_type`, `default_value`) VALUES (8,6,'name','Name','STRING','New all connection');
INSERT INTO `element_property_definition` (`property_definition_id`, `element_definition_id`, `name`, `display_name`, `property_type`, `default_value`) VALUES (9,6,'targetExpression','Target expression','EXPRESSION','expression:groovy:message.properties[\'r1\'] = result.payload');
INSERT INTO `element_property_definition` (`property_definition_id`, `element_definition_id`, `name`, `display_name`, `property_type`, `default_value`) VALUES (10,7,'name','Name','STRING','New wire tap router');
INSERT INTO `element_property_definition` (`property_definition_id`, `element_definition_id`, `name`, `display_name`, `property_type`, `default_value`) VALUES (11,8,'name','Name','STRING','New wire tap connection');
INSERT INTO `element_property_definition` (`property_definition_id`, `element_definition_id`, `name`, `display_name`, `property_type`, `default_value`) VALUES (12,9,'name','Name','STRING','New http fetcher');
INSERT INTO `element_property_definition` (`property_definition_id`, `element_definition_id`, `name`, `display_name`, `property_type`, `default_value`) VALUES (13,9,'urlExpression','URL expression','EXPRESSION','\'http://\'');
INSERT INTO `element_property_definition` (`property_definition_id`, `element_definition_id`, `name`, `display_name`, `property_type`, `default_value`) VALUES (14,9,'fetchMode','Fetch mode','ENUM','GET');
INSERT INTO `element_property_definition` (`property_definition_id`, `element_definition_id`, `name`, `display_name`, `property_type`, `default_value`) VALUES (15,9,'streaming','Use streaming mode?','BOOLEAN','false');
INSERT INTO `element_property_definition` (`property_definition_id`, `element_definition_id`, `name`, `display_name`, `property_type`, `default_value`) VALUES (16,10,'name','Name','STRING','New http message source');
INSERT INTO `element_property_definition` (`property_definition_id`, `element_definition_id`, `name`, `display_name`, `property_type`, `default_value`) VALUES (17,10,'port','Port','NUMBER','8811');
INSERT INTO `element_property_definition` (`property_definition_id`, `element_definition_id`, `name`, `display_name`, `property_type`, `default_value`) VALUES (18,10,'timeoutExpression','Timeout expression','EXPRESSION','return -1');
INSERT INTO `element_property_definition` (`property_definition_id`, `element_definition_id`, `name`, `display_name`, `property_type`, `default_value`) VALUES (19,11,'name','Name','STRING','New file reader');
INSERT INTO `element_property_definition` (`property_definition_id`, `element_definition_id`, `name`, `display_name`, `property_type`, `default_value`) VALUES (20,11,'directory','Directory expression','EXPRESSION','exp');
INSERT INTO `element_property_definition` (`property_definition_id`, `element_definition_id`, `name`, `display_name`, `property_type`, `default_value`) VALUES (21,11,'filePath','File path expression','EXPRESSION','exp');
INSERT INTO `element_property_definition` (`property_definition_id`, `element_definition_id`, `name`, `display_name`, `property_type`, `default_value`) VALUES (22,12,'name','Name','STRING','New dust renderer');
INSERT INTO `element_property_definition` (`property_definition_id`, `element_definition_id`, `name`, `display_name`, `property_type`, `default_value`) VALUES (23,12,'template','Template expression','EXPRESSION','exp');
INSERT INTO `element_property_definition` (`property_definition_id`, `element_definition_id`, `name`, `display_name`, `property_type`, `default_value`) VALUES (24,12,'jsonData','JSON data expression','EXPRESSION','exp');
INSERT INTO `element_property_definition` (`property_definition_id`, `element_definition_id`, `name`, `display_name`, `property_type`, `default_value`) VALUES (25,13,'name','Name','STRING','New log');
INSERT INTO `element_property_definition` (`property_definition_id`, `element_definition_id`, `name`, `display_name`, `property_type`, `default_value`) VALUES (26,13,'logName','Log name','STRING','Log name');
INSERT INTO `element_property_definition` (`property_definition_id`, `element_definition_id`, `name`, `display_name`, `property_type`, `default_value`) VALUES (27,13,'toLogExpression','String to be logged expression','EXPRESSION','exp');

