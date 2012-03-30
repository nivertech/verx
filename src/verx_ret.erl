%% Copyright (c) 2011-2012, Michael Santos <michael.santos@gmail.com>
%% All rights reserved.
%% 
%% Redistribution and use in source and binary forms, with or without
%% modification, are permitted provided that the following conditions
%% are met:
%% 
%% Redistributions of source code must retain the above copyright
%% notice, this list of conditions and the following disclaimer.
%% 
%% Redistributions in binary form must reproduce the above copyright
%% notice, this list of conditions and the following disclaimer in the
%% documentation and/or other materials provided with the distribution.
%% 
%% Neither the name of the author nor the names of its contributors
%% may be used to endorse or promote products derived from this software
%% without specific prior written permission.
%% 
%% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
%% "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
%% LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
%% FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
%% COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
%% INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
%% BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
%% LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
%% CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
%% LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
%% ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
%% POSSIBILITY OF SUCH DAMAGE.
-module(verx_ret).
-export([decode/2, param/1]).
-export([struct_to_proplist/1, api/0]).
-include("verx.hrl").

decode(Proc, Buf) ->
    case param(Proc) of
        {error, _} = Err ->
            Err;
        Args ->
            struct_to_proplist({Buf, Args})
    end.

param(supports_feature) ->
    [
         {supported, int}
    ];
param(get_type) ->
    [
         {type, remote_nonnull_string}
    ];
param(get_version) ->
    [
         {hv_ver, hyper}
    ];
param(get_lib_version) ->
    [
         {lib_ver, hyper}
    ];
param(get_hostname) ->
    [
         {hostname, remote_nonnull_string}
    ];
param(get_uri) ->
    [
         {uri, remote_nonnull_string}
    ];
param(get_max_vcpus) ->
    [
         {max_vcpus, int}
    ];
param(node_get_info) ->
    [
         {model, {char, 32}},
         {memory, hyper},
         {cpus, int},
         {mhz, int},
         {nodes, int},
         {sockets, int},
         {cores, int},
         {threads, int}
    ];
param(get_capabilities) ->
    [
         {capabilities, remote_nonnull_string}
    ];
param(node_get_cells_free_memory) ->
    [
         {freeMems, {hyper, {max, ?REMOTE_NODE_MAX_CELLS}}}
    ];
param(node_get_free_memory) ->
    [
         {freeMem, hyper}
    ];
param(domain_get_scheduler_type) ->
    [
         {type, remote_nonnull_string},
         {nparams, int}
    ];
param(domain_get_scheduler_parameters) ->
    [
         {params, {remote_sched_param, {max, ?REMOTE_DOMAIN_SCHEDULER_PARAMETERS_MAX}}}
    ];
param(domain_block_stats) ->
    [
         {rd_req, hyper},
         {rd_bytes, hyper},
         {wr_req, hyper},
         {wr_bytes, hyper},
         {errs, hyper}
    ];
param(domain_interface_stats) ->
    [
         {rx_bytes, hyper},
         {rx_packets, hyper},
         {rx_errs, hyper},
         {rx_drop, hyper},
         {tx_bytes, hyper},
         {tx_packets, hyper},
         {tx_errs, hyper},
         {tx_drop, hyper}
    ];
param(domain_memory_stats) ->
    [
         {stats, {remote_domain_memory_stat, {max, ?REMOTE_DOMAIN_MEMORY_STATS_MAX}}}
    ];
param(domain_block_peek) ->
    [
         {buffer, {opaque, {max, ?REMOTE_DOMAIN_BLOCK_PEEK_BUFFER_MAX}}}
    ];
param(domain_memory_peek) ->
    [
         {buffer, {opaque, {max, ?REMOTE_DOMAIN_MEMORY_PEEK_BUFFER_MAX}}}
    ];
param(list_domains) ->
    [
         {ids, {int, {max, ?REMOTE_DOMAIN_ID_LIST_MAX}}}
    ];
param(num_of_domains) ->
    [
         {num, int}
    ];
param(domain_create_xml) ->
    [
         {dom, remote_nonnull_domain}
    ];
param(domain_lookup_by_id) ->
    [
         {dom, remote_nonnull_domain}
    ];
param(domain_lookup_by_uuid) ->
    [
         {dom, remote_nonnull_domain}
    ];
param(domain_lookup_by_name) ->
    [
         {dom, remote_nonnull_domain}
    ];
param(domain_get_os_type) ->
    [
         {type, remote_nonnull_string}
    ];
param(domain_get_max_memory) ->
    [
         {memory, uhyper}
    ];
param(domain_get_info) ->
    [
         {state, {uchar, 1}},
         {max_mem, uhyper},
         {memory, uhyper},
         {nr_virt_cpu, ushort},
         {cpu_time, uhyper}
    ];
param(domain_dump_xml) ->
    [
         {xml, remote_nonnull_string}
    ];
param(domain_migrate_prepare) ->
    [
         {cookie, {opaque, {max, ?REMOTE_MIGRATE_COOKIE_MAX}}},
         {uri_out, remote_string}
    ];
param(domain_migrate_finish) ->
    [
         {ddom, remote_nonnull_domain}
    ];
param(list_defined_domains) ->
    [
         {names, {remote_nonnull_string, {max, ?REMOTE_DOMAIN_NAME_LIST_MAX}}}
    ];
param(num_of_defined_domains) ->
    [
         {num, int}
    ];
param(domain_define_xml) ->
    [
         {dom, remote_nonnull_domain}
    ];
param(domain_get_vcpus) ->
    [
         {info, {remote_vcpu_info, {max, ?REMOTE_VCPUINFO_MAX}}},
         {cpumaps, {opaque, {max, ?REMOTE_CPUMAPS_MAX}}}
    ];
param(domain_get_max_vcpus) ->
    [
         {num, int}
    ];
param(domain_get_security_label) ->
    [
         {label, {char, {max, ?REMOTE_SECURITY_LABEL_MAX}}},
         {enforcing, int}
    ];
param(node_get_security_model) ->
    [
         {model, {char, {max, ?REMOTE_SECURITY_MODEL_MAX}}},
         {doi, {char, {max, ?REMOTE_SECURITY_DOI_MAX}}}
    ];
param(domain_get_autostart) ->
    [
         {autostart, int}
    ];
param(num_of_networks) ->
    [
         {num, int}
    ];
param(list_networks) ->
    [
         {names, {remote_nonnull_string, {max, ?REMOTE_NETWORK_NAME_LIST_MAX}}}
    ];
param(num_of_defined_networks) ->
    [
         {num, int}
    ];
param(list_defined_networks) ->
    [
         {names, {remote_nonnull_string, {max, ?REMOTE_NETWORK_NAME_LIST_MAX}}}
    ];
param(network_lookup_by_uuid) ->
    [
         {net, remote_nonnull_network}
    ];
param(network_lookup_by_name) ->
    [
         {net, remote_nonnull_network}
    ];
param(network_create_xml) ->
    [
         {net, remote_nonnull_network}
    ];
param(network_define_xml) ->
    [
         {net, remote_nonnull_network}
    ];
param(network_dump_xml) ->
    [
         {xml, remote_nonnull_string}
    ];
param(network_get_bridge_name) ->
    [
         {name, remote_nonnull_string}
    ];
param(network_get_autostart) ->
    [
         {autostart, int}
    ];
param(num_of_interfaces) ->
    [
         {num, int}
    ];
param(list_interfaces) ->
    [
         {names, {remote_nonnull_string, {max, ?REMOTE_INTERFACE_NAME_LIST_MAX}}}
    ];
param(num_of_defined_interfaces) ->
    [
         {num, int}
    ];
param(list_defined_interfaces) ->
    [
         {names, {remote_nonnull_string, {max, ?REMOTE_DEFINED_INTERFACE_NAME_LIST_MAX}}}
    ];
param(interface_lookup_by_name) ->
    [
         {iface, remote_nonnull_interface}
    ];
param(interface_lookup_by_mac_string) ->
    [
         {iface, remote_nonnull_interface}
    ];
param(interface_get_xml_desc) ->
    [
         {xml, remote_nonnull_string}
    ];
param(interface_define_xml) ->
    [
         {iface, remote_nonnull_interface}
    ];
param(auth_list) ->
    [
         {types, {remote_auth_type, {max, ?REMOTE_AUTH_TYPE_LIST_MAX}}}
    ];
param(auth_sasl_init) ->
    [
         {mechlist, remote_nonnull_string}
    ];
param(auth_sasl_start) ->
    [
         {complete, int},
         {nil, int},
         {data, {char, {max, ?REMOTE_AUTH_SASL_DATA_MAX}}}
    ];
param(auth_sasl_step) ->
    [
         {complete, int},
         {nil, int},
         {data, {char, {max, ?REMOTE_AUTH_SASL_DATA_MAX}}}
    ];
param(auth_polkit) ->
    [
         {complete, int}
    ];
param(num_of_storage_pools) ->
    [
         {num, int}
    ];
param(list_storage_pools) ->
    [
         {names, {remote_nonnull_string, {max, ?REMOTE_STORAGE_POOL_NAME_LIST_MAX}}}
    ];
param(num_of_defined_storage_pools) ->
    [
         {num, int}
    ];
param(list_defined_storage_pools) ->
    [
         {names, {remote_nonnull_string, {max, ?REMOTE_STORAGE_POOL_NAME_LIST_MAX}}}
    ];
param(find_storage_pool_sources) ->
    [
         {xml, remote_nonnull_string}
    ];
param(storage_pool_lookup_by_uuid) ->
    [
         {pool, remote_nonnull_storage_pool}
    ];
param(storage_pool_lookup_by_name) ->
    [
         {pool, remote_nonnull_storage_pool}
    ];
param(storage_pool_lookup_by_volume) ->
    [
         {pool, remote_nonnull_storage_pool}
    ];
param(storage_pool_create_xml) ->
    [
         {pool, remote_nonnull_storage_pool}
    ];
param(storage_pool_define_xml) ->
    [
         {pool, remote_nonnull_storage_pool}
    ];
param(storage_pool_dump_xml) ->
    [
         {xml, remote_nonnull_string}
    ];
param(storage_pool_get_info) ->
    [
         {state, {uchar, 1}},
         {capacity, uhyper},
         {allocation, uhyper},
         {available, uhyper}
    ];
param(storage_pool_get_autostart) ->
    [
         {autostart, int}
    ];
param(storage_pool_num_of_volumes) ->
    [
         {num, int}
    ];
param(storage_pool_list_volumes) ->
    [
         {names, {remote_nonnull_string, {max, ?REMOTE_STORAGE_VOL_NAME_LIST_MAX}}}
    ];
param(storage_vol_lookup_by_name) ->
    [
         {vol, remote_nonnull_storage_vol}
    ];
param(storage_vol_lookup_by_key) ->
    [
         {vol, remote_nonnull_storage_vol}
    ];
param(storage_vol_lookup_by_path) ->
    [
         {vol, remote_nonnull_storage_vol}
    ];
param(storage_vol_create_xml) ->
    [
         {vol, remote_nonnull_storage_vol}
    ];
param(storage_vol_create_xml_from) ->
    [
         {vol, remote_nonnull_storage_vol}
    ];
param(storage_vol_dump_xml) ->
    [
         {xml, remote_nonnull_string}
    ];
param(storage_vol_get_info) ->
    [
         {type, {char, 1}},
         {capacity, uhyper},
         {allocation, uhyper}
    ];
param(storage_vol_get_path) ->
    [
         {name, remote_nonnull_string}
    ];
param(node_num_of_devices) ->
    [
         {num, int}
    ];
param(node_list_devices) ->
    [
         {names, {remote_nonnull_string, {max, ?REMOTE_NODE_DEVICE_NAME_LIST_MAX}}}
    ];
param(node_device_lookup_by_name) ->
    [
         {dev, remote_nonnull_node_device}
    ];
param(node_device_dump_xml) ->
    [
         {xml, remote_nonnull_string}
    ];
param(node_device_get_parent) ->
    [
         {parent, remote_string}
    ];
param(node_device_num_of_caps) ->
    [
         {num, int}
    ];
param(node_device_list_caps) ->
    [
         {names, {remote_nonnull_string, {max, ?REMOTE_NODE_DEVICE_CAPS_LIST_MAX}}}
    ];
param(node_device_create_xml) ->
    [
         {dev, remote_nonnull_node_device}
    ];
param(domain_events_register) ->
    [
         {cb_registered, int}
    ];
param(domain_events_deregister) ->
    [
         {cb_registered, int}
    ];
param(domain_xml_from_native) ->
    [
         {domainXml, remote_nonnull_string}
    ];
param(domain_xml_to_native) ->
    [
         {nativeConfig, remote_nonnull_string}
    ];
param(num_of_secrets) ->
    [
         {num, int}
    ];
param(list_secrets) ->
    [
         {uuids, {remote_nonnull_string, {max, ?REMOTE_SECRET_UUID_LIST_MAX}}}
    ];
param(secret_lookup_by_uuid) ->
    [
         {secret, remote_nonnull_secret}
    ];
param(secret_define_xml) ->
    [
         {secret, remote_nonnull_secret}
    ];
param(secret_get_xml_desc) ->
    [
         {xml, remote_nonnull_string}
    ];
param(secret_get_value) ->
    [
         {value, {opaque, {max, ?REMOTE_SECRET_VALUE_MAX}}}
    ];
param(secret_lookup_by_usage) ->
    [
         {secret, remote_nonnull_secret}
    ];
param(is_secure) ->
    [
         {secure, int}
    ];
param(domain_is_active) ->
    [
         {active, int}
    ];
param(domain_is_persistent) ->
    [
         {persistent, int}
    ];
param(network_is_active) ->
    [
         {active, int}
    ];
param(network_is_persistent) ->
    [
         {persistent, int}
    ];
param(storage_pool_is_active) ->
    [
         {active, int}
    ];
param(storage_pool_is_persistent) ->
    [
         {persistent, int}
    ];
param(interface_is_active) ->
    [
         {active, int}
    ];
param(cpu_compare) ->
    [
         {result, int}
    ];

param(_) ->
    {error, unsupported}.


struct_to_proplist({Buf, Struct}) ->
    {Values, _Remainder} = verx_xdr:struct(Buf, Struct),
    proplist(Values, Struct, []).

proplist([], [], Acc) ->
    lists:reverse(Acc);
proplist([{Type, [Val|_] = Vals}|T1], [{Field, Type}|T2], Acc) when is_tuple(Val) ->
    case verx_xdr:struct_to_proplist({Type, Vals}) of
        {error, _} ->
            {error, {Type, Field}, lists:reverse(Acc)};
        L ->
            proplist(T1, T2, [{Field, L}|Acc])
    end;
proplist([{Type, Val}|T1], [{Field, {Type, _Len}}|T2], Acc) ->
    Val1 = case Type of
        T when T == char; T == uchar -> hd(binary:split(Val, <<0>>));
        _ -> Val
    end,
    proplist(T1, T2, [{Field, Val1}|Acc]);
proplist([{Type, Val}|T1], [{Field, Type}|T2], Acc) ->
    proplist(T1, T2, [{Field, Val}|Acc]).

api() -> [
	supports_feature,
	get_type,
	get_version,
	get_lib_version,
	get_hostname,
	get_uri,
	get_max_vcpus,
	node_get_info,
	get_capabilities,
	node_get_cells_free_memory,
	node_get_free_memory,
	domain_get_scheduler_type,
	domain_get_scheduler_parameters,
	domain_block_stats,
	domain_interface_stats,
	domain_memory_stats,
	domain_block_peek,
	domain_memory_peek,
	list_domains,
	num_of_domains,
	domain_create_xml,
	domain_lookup_by_id,
	domain_lookup_by_uuid,
	domain_lookup_by_name,
	domain_get_os_type,
	domain_get_max_memory,
	domain_get_info,
	domain_dump_xml,
	domain_migrate_prepare,
	domain_migrate_finish,
	list_defined_domains,
	num_of_defined_domains,
	domain_define_xml,
	domain_get_vcpus,
	domain_get_max_vcpus,
	domain_get_security_label,
	node_get_security_model,
	domain_get_autostart,
	num_of_networks,
	list_networks,
	num_of_defined_networks,
	list_defined_networks,
	network_lookup_by_uuid,
	network_lookup_by_name,
	network_create_xml,
	network_define_xml,
	network_dump_xml,
	network_get_bridge_name,
	network_get_autostart,
	num_of_interfaces,
	list_interfaces,
	num_of_defined_interfaces,
	list_defined_interfaces,
	interface_lookup_by_name,
	interface_lookup_by_mac_string,
	interface_get_xml_desc,
	interface_define_xml,
	auth_list,
	auth_sasl_init,
	auth_sasl_start,
	auth_sasl_step,
	auth_polkit,
	num_of_storage_pools,
	list_storage_pools,
	num_of_defined_storage_pools,
	list_defined_storage_pools,
	find_storage_pool_sources,
	storage_pool_lookup_by_uuid,
	storage_pool_lookup_by_name,
	storage_pool_lookup_by_volume,
	storage_pool_create_xml,
	storage_pool_define_xml,
	storage_pool_dump_xml,
	storage_pool_get_info,
	storage_pool_get_autostart,
	storage_pool_num_of_volumes,
	storage_pool_list_volumes,
	storage_vol_lookup_by_name,
	storage_vol_lookup_by_key,
	storage_vol_lookup_by_path,
	storage_vol_create_xml,
	storage_vol_create_xml_from,
	storage_vol_dump_xml,
	storage_vol_get_info,
	storage_vol_get_path,
	node_num_of_devices,
	node_list_devices,
	node_device_lookup_by_name,
	node_device_dump_xml,
	node_device_get_parent,
	node_device_num_of_caps,
	node_device_list_caps,
	node_device_create_xml,
	domain_events_register,
	domain_events_deregister,
	domain_xml_from_native,
	domain_xml_to_native,
	num_of_secrets,
	list_secrets,
	secret_lookup_by_uuid,
	secret_define_xml,
	secret_get_xml_desc,
	secret_get_value,
	secret_lookup_by_usage,
	is_secure,
	domain_is_active,
	domain_is_persistent,
	network_is_active,
	network_is_persistent,
	storage_pool_is_active,
	storage_pool_is_persistent,
	interface_is_active,
	cpu_compare
].
