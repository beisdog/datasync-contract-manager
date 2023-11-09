--
-- Licensed to JumpMind Inc under one or more contributor
-- license agreements.  See the NOTICE file distributed
-- with this work for additional information regarding
-- copyright ownership.  JumpMind Inc licenses this file
-- to you under the GNU General Public License, version 3.0 (GPLv3)
-- (the "License"); you may not use this file except in compliance
-- with the License.
--
-- You should have received a copy of the GNU General Public License,
-- version 3.0 (GPLv3) along with this library; if not, see
-- <http://www.gnu.org/licenses/>.
--
-- Unless required by applicable law or agreed to in writing,
-- software distributed under the License is distributed on an
-- "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
-- KIND, either express or implied.  See the License for the
-- specific language governing permissions and limitations
-- under the License.
--

-- ----------------------------------------------------------------------------
-- Sample Data
-- ----------------------------------------------------------------------------
delete from address;
delete from contract;
delete from partner;
-- partner
insert into partner (partner_id, first_name, last_name, birthdate, email, mobile_phone) values (1, 'David','Beisert','1976-07-04','beisdog@web.de','+41782420711');
insert into address (address_id, partner_id, street, city, zipcode) values (1, 1, 'Farnsburgerstrasse 54', 'BS', '4052');
insert into partner (partner_id, first_name, last_name, birthdate, email, mobile_phone) values (2, 'Olivia','Beisert','2019-12-08','olivdog@web.de','+41782420711');
insert into address (address_id, partner_id, street, city, zipcode) values (2, 2, 'Farnsburgerstrasse 54', 'BS', '4052');

-- contracts
insert into contract (contract_id, partner_id, contract_type, title, start_date, text)
values (1, 1, 'KV', 'Krankenversicherung für David Beisert', '2016-01-01', 'Der Kunde ist versichert im Krankheitsfall Leistung zu bekommen');
insert into contract (contract_id, partner_id, contract_type, title, start_date, text)
values (2, 1, 'UV', 'Unfallversicherung für David Beisert', '2016-01-01', 'Der Kunde ist versichert im Unfallsfall Leistung zu bekommen');
insert into contract (contract_id, partner_id, contract_type, title, start_date, text)
values (3, 2, 'KV', 'Krankenversicherung für Olivia Beisert', '2016-01-01', 'Der Kunde ist versichert im Krankheitsfall Leistung zu bekommen');
insert into contract (contract_id, partner_id, contract_type, title, start_date, text)
values (4, 2, 'UV', 'Unfallversicherung für Olivia Beisert', '2016-01-01', 'Der Kunde ist versichert im Unfallsfall Leistung zu bekommen');

-- ----------------------------------------------------------------------------
-- Clear and load SymmetricDS Configuration
-- ----------------------------------------------------------------------------

delete from sym_trigger_router;
delete from sym_trigger;
delete from sym_router;
delete from sym_channel where channel_id in ('partner', 'contract');
delete from sym_node_group_link;
delete from sym_node_group;
delete from sym_node_host;
delete from sym_node_identity;
delete from sym_node_security;
delete from sym_node;
delete from sym_data_event;
delete from sym_data;

-- ----------------------------------------------------------------------------
-- Channels
-- ----------------------------------------------------------------------------

-- Channel "sale_transaction" for tables related to sales and refunds
insert into sym_channel 
(channel_id, processing_order, max_batch_size, enabled, description)
values('partner', 1, 100000, 1, 'partner data');

-- Channel "item" for tables related to items for purchase
insert into sym_channel 
(channel_id, processing_order, max_batch_size, enabled, description)
values('contract', 1, 100000, 1, 'contract data');

-- ----------------------------------------------------------------------------
-- Node Groups
-- ----------------------------------------------------------------------------

insert into sym_node_group (node_group_id) values ('app');
insert into sym_node_group (node_group_id) values ('partner');
insert into sym_node_group (node_group_id) values ('contract');


-- ----------------------------------------------------------------------------
-- Node Group Links
-- ----------------------------------------------------------------------------

-- Corp sends changes to Store when Store pulls from Corp
insert into sym_node_group_link (source_node_group_id, target_node_group_id, data_event_action) values ('app', 'contract', 'W');
insert into sym_node_group_link (source_node_group_id, target_node_group_id, data_event_action) values ('app', 'partner', 'W');


-- Store sends changes to Corp when Store pushes to Corp
insert into sym_node_group_link (source_node_group_id, target_node_group_id, data_event_action) values ('contract', 'app', 'P');
insert into sym_node_group_link (source_node_group_id, target_node_group_id, data_event_action) values ('partner', 'app', 'P');
-- ----------------------------------------------------------------------------
-- Triggers
-- ----------------------------------------------------------------------------

-- Triggers for tables on "item" channel
insert into sym_trigger 
(trigger_id,source_table_name,channel_id,last_update_time,create_time)
values('partner','partner','partner',current_timestamp,current_timestamp);

insert into sym_trigger 
(trigger_id,source_table_name,channel_id,last_update_time,create_time)
values('address','address','partner',current_timestamp,current_timestamp);

-- Triggers for tables on "sale_transaction" channel
insert into sym_trigger 
(trigger_id,source_table_name,channel_id,last_update_time,create_time)
values('contract','contract','contract',current_timestamp,current_timestamp);

-- insert into sym_trigger
-- (trigger_id,source_table_name,channel_id,last_update_time,create_time)
-- values('sale_return_line_item','sale_return_line_item','sale_transaction',current_timestamp,current_timestamp);
--
-- -- Triggers with capture disabled, so they are used for initial load only
-- insert into sym_trigger
-- (trigger_id,source_table_name,channel_id, sync_on_insert, sync_on_update, sync_on_delete,last_update_time,create_time)
-- values('sale_transaction_corp','sale_transaction','sale_transaction',0,0,0,current_timestamp,current_timestamp);
--
-- insert into sym_trigger
-- (trigger_id,source_table_name,channel_id, sync_on_insert, sync_on_update, sync_on_delete,last_update_time,create_time)
-- values('sale_return_line_item_corp','sale_return_line_item','sale_transaction',0,0,0,current_timestamp,current_timestamp);

-- ----------------------------------------------------------------------------
-- Routers
-- ----------------------------------------------------------------------------

-- Default router sends all data from app to partner and contract and vice versa
insert into sym_router 
(router_id,source_node_group_id,target_node_group_id,router_type,create_time,last_update_time)
values('app_2_partner', 'app', 'partner', 'default',current_timestamp, current_timestamp);
insert into sym_router
(router_id,source_node_group_id,target_node_group_id,router_type,create_time,last_update_time)
values('app_2_contract', 'app', 'contract', 'default',current_timestamp, current_timestamp);
insert into sym_router
(router_id,source_node_group_id,target_node_group_id,router_type,create_time,last_update_time)
values('partner_2_app', 'partner', 'app', 'default',current_timestamp, current_timestamp);
insert into sym_router
(router_id,source_node_group_id,target_node_group_id,router_type,create_time,last_update_time)
values('contract_2_app', 'contract', 'app', 'default',current_timestamp, current_timestamp);

-- Default router sends all data from store to corp
-- insert into sym_router
-- (router_id,source_node_group_id,target_node_group_id,router_type,create_time,last_update_time)
-- values('store_2_corp', 'store', 'corp', 'default',current_timestamp, current_timestamp);

-- Column match router will subset data from corp to specific store
-- insert into sym_router
-- (router_id,source_node_group_id,target_node_group_id,router_type,router_expression,create_time,last_update_time)
-- values('corp_2_one_store', 'corp', 'store', 'column','STORE_ID=:EXTERNAL_ID or OLD_STORE_ID=:EXTERNAL_ID',current_timestamp, current_timestamp);


-- ----------------------------------------------------------------------------
-- Trigger Routers
-- ----------------------------------------------------------------------------
-- partner
insert into sym_trigger_router
(trigger_id,router_id,initial_load_order,last_update_time,create_time)
values('partner','app_2_partner', 200, current_timestamp, current_timestamp);
insert into sym_trigger_router
(trigger_id,router_id,initial_load_order,last_update_time,create_time)
values('address','app_2_partner', 200, current_timestamp, current_timestamp);
insert into sym_trigger_router
(trigger_id,router_id,initial_load_order,last_update_time,create_time)
values('partner','partner_2_app', 200, current_timestamp, current_timestamp);
insert into sym_trigger_router
(trigger_id,router_id,initial_load_order,last_update_time,create_time)
values('address','partner_2_app', 200, current_timestamp, current_timestamp);
-- contract
insert into sym_trigger_router
(trigger_id,router_id,initial_load_order,last_update_time,create_time)
values('contract','app_2_contract', 200, current_timestamp, current_timestamp);
insert into sym_trigger_router
(trigger_id,router_id,initial_load_order,last_update_time,create_time)
values('contract','contract_2_app', 200, current_timestamp, current_timestamp);
-- Send all items to all stores
-- insert into sym_trigger_router
-- (trigger_id,router_id,initial_load_order,last_update_time,create_time)
-- values('item','corp_2_store', 100, current_timestamp, current_timestamp);

-- Send item prices to associated stores
-- insert into sym_trigger_router
-- (trigger_id,router_id,initial_load_order,initial_load_select,last_update_time,create_time)
-- values('partner','corp_2_one_store',100,'store_id=''$(externalId)''',current_timestamp,current_timestamp);

-- Send all sales transactions to corp
-- insert into sym_trigger_router
-- (trigger_id,router_id,initial_load_order,last_update_time,create_time)
-- values('sale_transaction','store_2_corp', 200, current_timestamp, current_timestamp);
--
-- insert into sym_trigger_router
-- (trigger_id,router_id,initial_load_order,last_update_time,create_time)
-- values('sale_return_line_item','store_2_corp', 200, current_timestamp, current_timestamp);
--
-- -- Send all sales transactions to store during initial load
-- insert into sym_trigger_router
-- (trigger_id,router_id,initial_load_order,last_update_time,create_time)
-- values('sale_transaction_corp','corp_2_store', 200, current_timestamp, current_timestamp);
--
-- insert into sym_trigger_router
-- (trigger_id,router_id,initial_load_order,last_update_time,create_time)
-- values('sale_return_line_item_corp','corp_2_store', 200, current_timestamp, current_timestamp);

