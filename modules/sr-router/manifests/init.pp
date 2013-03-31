class sr-router {
  include sr-router::bind
  include sr-router::dhcp
  include sr-router::groups
  include sr-router::helpdesk-tracker
  include sr-router::mrtg
  include sr-router::ntop
  include sr-router::sysctl
  include sr-router::sudo
  include sr-router::scripts
}
