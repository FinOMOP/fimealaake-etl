-- change owner before each migration (all objects created are owned by schema admin, not flyway login role)
SET ROLE ${admin_role};
