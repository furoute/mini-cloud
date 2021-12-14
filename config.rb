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
	:disk_size => 30,
	:osd_size => '100G'
}


$storage_vars = {
	:vcpu => 4,
	:ram => 4096,
	:disk => 30
}