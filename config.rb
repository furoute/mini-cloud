$groups = {
	'cluster' => [
		'pve-node1',
		'pve-node2',
		'pve-node3'
	],
	'storage' => [
		'target1'
	]
}

$cluster_vars = {
	:vcpu => 8,
	:ram => 16384,
	:storage => '200G'
}


$storage_vars = {
	:vcpu => 2,
	:ram => 2048,
	:storage => '10G'
}