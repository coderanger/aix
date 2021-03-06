###########
# variables
###########

target_lvl_sp='7100-03-04-1441'
target_lvl_tl='7100-04-00'
target_lvl_latest='laTEst'
package_dir='/export/extra/lpp_source'
suma_client_list='quimby*'
nim_client_list='quimby07,quimby08,quimby09,quimby10,quimby11,quimby12'

=begin
Initial conditions
------------------
quimby07 => 7100-01-04-1216
quimby08 => 7100-03-01-1341
quimby09 => 7100-03-04-1441 (ref)
quimby10 => 7100-03-05-1524
quimby11 => 7100-04-00-0000
quimby12 => 7200-00-02-1614
=end

ohai 'reload_nim' do
  action :nothing
  plugin 'nim'
end

#################
# SUMA
# Download specific SP/TL or latest installation images.
# And define NIM lpp_source object.
#################
=begin
aix_suma "Downloading SP images" do
	oslevel		"#{target_lvl_sp}"		# Name of the oslevel to download (if empty, assume latest)
	location	"#{package_dir}"		# Directory where the lpp will be stored and (if empty, assume /usr/sys/inst.images). If the directory does not exist, it will be created.
	targets		"#{suma_client_list}"	# Mandatory list of standalone or master NIM 'machines' resources
	action 		:download
end

aix_suma "Downloading TL images" do
	oslevel		"#{target_lvl_tl}"		# Name of the oslevel to download (if empty, assume latest)
	location	"#{package_dir}"		# Directory where the lpp will be stored and (if empty, assume /usr/sys/inst.images). If the directory does not exist, it will be created.
	targets		"#{suma_client_list}"	# Mandatory list of standalone or master NIM 'machines' resources
	action 		:download
end

aix_suma "Downloading LATEST images" do
	oslevel		"#{target_lvl_latest}"	# Name of the oslevel to download (if empty, assume latest)
	location	"#{package_dir}"		# Directory where the lpp will be stored and (if empty, assume /usr/sys/inst.images). If the directory does not exist, it will be created.
	targets		"#{suma_client_list}"	# Mandatory list of standalone or master NIM 'machines' resources
	action 		:download
end
=end

#################
# NIM
# Perfom nim cust operation on each targets based on their oslevel.
#################

aix_nim "Updating machines" do
	lpp_source	"#{target_lvl_sp}-lpp_source"
	targets		"#{nim_client_list}"
	action		:update
	#notifies	:reload, 'ohai[reload_nim]', :before
end
