-- Simple OpenDCIM Demo Data for Academic Demonstration
-- Basic data to show DCIM capabilities for AI infrastructure

-- Create basic manufacturers if they don't exist
INSERT IGNORE INTO fac_Manufacturer (Name) VALUES
('NVIDIA'), ('Dell Technologies'), ('HPE'), ('Cisco');

-- Create a basic data center
INSERT IGNORE INTO fac_DataCenter (
    Name, SquareFootage, DeliveryAddress, countryCode, Administrator, MaxkW
) VALUES (
    'AI Research Center Madrid', 15000, 'Madrid, Spain', 'ES', 'admin', 5000
);

-- Get manufacturer IDs
SET @nvidia_id = (SELECT ManufacturerID FROM fac_Manufacturer WHERE Name = 'NVIDIA' LIMIT 1);
SET @dell_id = (SELECT ManufacturerID FROM fac_Manufacturer WHERE Name = 'Dell Technologies' LIMIT 1);

-- Create device templates with all required fields
INSERT IGNORE INTO fac_DeviceTemplate (
    ManufacturerID, Model, Height, Weight, Wattage, DeviceType,
    PSCount, NumPorts, Notes, ChassisSlots, RearChassisSlots
) VALUES
(@nvidia_id, 'DGX A100', 6, 124, 6500, 'Server', 4, 8, '8x NVIDIA A100 GPUs', 0, 0),
(@nvidia_id, 'DGX H100', 6, 124, 10200, 'Server', 4, 8, '8x NVIDIA H100 GPUs', 0, 0),
(@dell_id, 'PowerEdge R750', 2, 24, 800, 'Server', 2, 8, 'Management Server', 0, 0);

-- Create cabinet rows
INSERT IGNORE INTO fac_CabRow (Name, DataCenterID, ZoneID) VALUES
('AI Training Row', 1, 0),
('AI Inference Row', 1, 0),
('Storage Row', 1, 0);

-- Create cabinets
INSERT IGNORE INTO fac_Cabinet (
    DataCenterID, Location, LocationSortable, AssignedTo, ZoneID, CabRowID,
    CabinetHeight, Model, MaxKW, MaxWeight, InstallationDate, FrontEdge
) VALUES
(1, 'AI-01', 'AI-001', 0, 0, 1, 42, 'Standard Rack', 25, 2000, CURDATE(), 'Top'),
(1, 'AI-02', 'AI-002', 0, 0, 1, 42, 'Standard Rack', 25, 2000, CURDATE(), 'Top'),
(1, 'INF-01', 'INF-001', 0, 0, 2, 42, 'Standard Rack', 25, 2000, CURDATE(), 'Top'),
(1, 'STOR-01', 'STOR-001', 0, 0, 3, 42, 'Standard Rack', 15, 1800, CURDATE(), 'Top');

-- Get template IDs
SET @dgx_a100_template = (SELECT TemplateID FROM fac_DeviceTemplate WHERE Model = 'DGX A100' LIMIT 1);
SET @dgx_h100_template = (SELECT TemplateID FROM fac_DeviceTemplate WHERE Model = 'DGX H100' LIMIT 1);
SET @r750_template = (SELECT TemplateID FROM fac_DeviceTemplate WHERE Model = 'PowerEdge R750' LIMIT 1);

-- Create departments
INSERT IGNORE INTO fac_Department (Name, ExecSponsor) VALUES
('AI Research', 'Dr. García'),
('ML Engineering', 'Dr. Rodríguez'),
('DevOps', 'Ing. Fernández');

-- Create people
INSERT IGNORE INTO fac_People (UserID, LastName, FirstName, Phone1, Email, Department) VALUES
('mgarcia', 'García', 'María', '+34-91-1234567', 'm.garcia@ai.es', 1),
('crodriguez', 'Rodríguez', 'Carlos', '+34-91-1234568', 'c.rodriguez@ai.es', 2),
('lfernandez', 'Fernández', 'Luis', '+34-91-1234569', 'l.fernandez@ai.es', 3);

-- Create GPU training servers
INSERT IGNORE INTO fac_Device (
    Label, SerialNo, AssetTag, PrimaryIP, Owner, Cabinet, Position, Height,
    Ports, TemplateID, NominalWatts, PowerSupplyCount, DeviceType,
    InstallDate, Status, Notes
) VALUES
-- Training Servers (DGX A100)
('AI-TRAIN-01', 'DGX-001', 'AT-001', '10.1.1.101', 1, 1, 1, 6, 8, @dgx_a100_template, 6500, 4, 'Server', CURDATE(), 'Production', 'LLM Training - GPT Models'),
('AI-TRAIN-02', 'DGX-002', 'AT-002', '10.1.1.102', 1, 1, 8, 6, 8, @dgx_a100_template, 6500, 4, 'Server', CURDATE(), 'Production', 'LLM Training - BERT Models'),
('AI-TRAIN-03', 'DGX-003', 'AT-003', '10.1.1.103', 1, 1, 15, 6, 8, @dgx_a100_template, 6500, 4, 'Server', CURDATE(), 'Production', 'Computer Vision Training'),
('AI-TRAIN-04', 'DGX-004', 'AT-004', '10.1.1.104', 1, 2, 1, 6, 8, @dgx_a100_template, 6500, 4, 'Server', CURDATE(), 'Production', 'Multimodal AI Training'),
('AI-TRAIN-05', 'DGX-005', 'AT-005', '10.1.1.105', 1, 2, 8, 6, 8, @dgx_a100_template, 6500, 4, 'Server', CURDATE(), 'Production', 'Reinforcement Learning'),
('AI-TRAIN-06', 'DGX-006', 'AT-006', '10.1.1.106', 1, 2, 15, 6, 8, @dgx_a100_template, 6500, 4, 'Server', CURDATE(), 'Production', 'Research Workloads'),

-- Inference Servers (DGX H100)
('AI-INFER-01', 'H100-001', 'AI-001', '10.1.2.101', 2, 3, 1, 6, 8, @dgx_h100_template, 10200, 4, 'Server', CURDATE(), 'Production', 'Real-time Inference - ChatBot'),
('AI-INFER-02', 'H100-002', 'AI-002', '10.1.2.102', 2, 3, 8, 6, 8, @dgx_h100_template, 10200, 4, 'Server', CURDATE(), 'Production', 'Real-time Inference - Vision'),
('AI-INFER-03', 'H100-003', 'AI-003', '10.1.2.103', 2, 3, 15, 6, 8, @dgx_h100_template, 10200, 4, 'Server', CURDATE(), 'Production', 'Batch Inference - Analytics'),

-- Management Servers
('MGT-01', 'R750-001', 'MG-001', '10.1.4.201', 3, 4, 1, 2, 8, @r750_template, 800, 2, 'Server', CURDATE(), 'Production', 'Kubernetes Master Node'),
('MGT-02', 'R750-002', 'MG-002', '10.1.4.202', 3, 4, 4, 2, 8, @r750_template, 800, 2, 'Server', CURDATE(), 'Production', 'Monitoring Server');

-- Create tags for categorization
INSERT IGNORE INTO fac_Tags (TagName, TagColor) VALUES
('AI-Training', 'FF0000'),
('AI-Inference', '00FF00'),
('GPU-Compute', 'FF8800'),
('Critical', 'FF0000'),
('Management', '0000FF');

-- Get tag IDs and associate with devices
SET @training_tag = (SELECT TagID FROM fac_Tags WHERE TagName = 'AI-Training' LIMIT 1);
SET @inference_tag = (SELECT TagID FROM fac_Tags WHERE TagName = 'AI-Inference' LIMIT 1);
SET @gpu_tag = (SELECT TagID FROM fac_Tags WHERE TagName = 'GPU-Compute' LIMIT 1);
SET @critical_tag = (SELECT TagID FROM fac_Tags WHERE TagName = 'Critical' LIMIT 1);
SET @mgmt_tag = (SELECT TagID FROM fac_Tags WHERE TagName = 'Management' LIMIT 1);

-- Tag training servers
INSERT IGNORE INTO fac_DeviceTags (DeviceID, TagID)
SELECT DeviceID, @training_tag FROM fac_Device WHERE Label LIKE 'AI-TRAIN-%';

INSERT IGNORE INTO fac_DeviceTags (DeviceID, TagID)
SELECT DeviceID, @gpu_tag FROM fac_Device WHERE Label LIKE 'AI-TRAIN-%';

INSERT IGNORE INTO fac_DeviceTags (DeviceID, TagID)
SELECT DeviceID, @critical_tag FROM fac_Device WHERE Label LIKE 'AI-TRAIN-%';

-- Tag inference servers
INSERT IGNORE INTO fac_DeviceTags (DeviceID, TagID)
SELECT DeviceID, @inference_tag FROM fac_Device WHERE Label LIKE 'AI-INFER-%';

INSERT IGNORE INTO fac_DeviceTags (DeviceID, TagID)
SELECT DeviceID, @gpu_tag FROM fac_Device WHERE Label LIKE 'AI-INFER-%';

INSERT IGNORE INTO fac_DeviceTags (DeviceID, TagID)
SELECT DeviceID, @critical_tag FROM fac_Device WHERE Label LIKE 'AI-INFER-%';

-- Tag management servers
INSERT IGNORE INTO fac_DeviceTags (DeviceID, TagID)
SELECT DeviceID, @mgmt_tag FROM fac_Device WHERE Label LIKE 'MGT-%';

-- Add some VM inventory
INSERT IGNORE INTO fac_VMInventory (
    DeviceID, vmID, vmName, vmState, Owner, PrimaryContact, LastUpdated, vmNotes
) VALUES
(10, 'vm-k8s-master', 'k8s-master-01', 'on', 3, 3, NOW(), 'Kubernetes Master Node'),
(10, 'vm-prometheus', 'prometheus-monitoring', 'on', 3, 3, NOW(), 'Prometheus Monitoring'),
(11, 'vm-grafana', 'grafana-dashboard', 'on', 3, 3, NOW(), 'Grafana Dashboards'),
(11, 'vm-jupyter', 'jupyterhub-ai', 'on', 2, 2, NOW(), 'JupyterHub for AI Research');

-- Summary: This creates a realistic AI data center with:
-- - 6 GPU training servers (DGX A100)
-- - 3 GPU inference servers (DGX H100)
-- - 2 management servers (Dell R750)
-- - 4 cabinets organized by function
-- - Proper categorization with tags
-- - Basic organizational structure