# Update Value helper

Helps Updating the value in the Value Object. Also notifies parent and child pipes in the "family" of the value change (dirty)
so they can update their own (cached) values accordingly.

- update : Updates the Value Object and notifies family pipes if successful (validated ok)