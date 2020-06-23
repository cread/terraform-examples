# ec2-spot-autoscale

This example creates an autoscaling group that launches spot instances
that serve HTTP content via an Elastic Load Balancer. Please note that there
is quite a bit of lag time (in the order of 2 minutes or so) between the instance
coming up and it being able to serve HTTP requests. This is because we're
installing the OS provided `nginx` package via [cloud-init](https://cloudinit.readthedocs.org/). See the `cloud-init.cfg` file here for details.

## VPC Notes

The configuration here simply uses your default VPC and subnets.
