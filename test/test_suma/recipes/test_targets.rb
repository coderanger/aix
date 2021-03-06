
node.default['nim']['clients'] = {'client1'=>{'oslevel'=>'7100-02-01'},
								  'client2'=>{'oslevel'=>'7100-03-01'},
								  'client3'=>{'oslevel'=>'7100-04-01'}}

aix_suma "31. Valid client list with wildcard" do
  oslevel   '7100-02-02'
  location  '/tmp/img.source/31/'
  targets   'client*'
  action    :download
end

aix_suma "32. Mostly valid client list" do
  oslevel   '7100-02-02'
  location  '/tmp/img.source/32/'
  targets   'client1,invalid,client3'
  action    :download
end

aix_suma "34. Default property targets (all nim clients)" do
  oslevel   '7100-02-02'
  location  '/tmp/img.source/34/'
  #targets	'default'
  action    :download
end

aix_suma "35. Empty property targets (all nim clients)" do
  oslevel   '7100-02-02'
  location  '/tmp/img.source/35/'
  targets   ''
  action    :download
end
