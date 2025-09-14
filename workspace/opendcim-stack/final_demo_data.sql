-- Final OpenDCIM Demo Data for Academic Demonstration
-- Creates working AI infrastructure demo data

-- 1. Create manufacturers
INSERT IGNORE INTO fac_Manufacturer (Name) VALUES ('NVIDIA'), ('Dell'), ('HPE');

-- 2. Create data center
INSERT IGNORE INTO fac_DataCenter (
    Name, SquareFootage, DeliveryAddress, countryCode, Administrator, MaxkW
) VALUES (
    'AI Research Center Madrid', 15000, 'Madrid, Spain', 'ES', 'admin', 5000
);

-- 3. Create device templates with proper structure
INSERT IGNORE INTO fac_DeviceTemplate (
    ManufacturerID, Model, Height, Weight, Wattage, DeviceType,
    PSCount, NumPorts, Notes, ChassisSlots, RearChassisSlots
) VALUES
(1, 'DGX A100', 6, 124, 6500, 'Server', 4, 8, '8x NVIDIA A100 80GB GPUs for LLM Training', 0, 0),
(1, 'DGX H100', 6, 124, 10200, 'Server', 4, 8, '8x NVIDIA H100 80GB GPUs for Inference', 0, 0),
(2, 'PowerEdge R750', 2, 24, 800, 'Server', 2, 8, 'Management and Orchestration Server', 0, 0);

-- 4. Create cabinet rows
INSERT IGNORE INTO fac_CabRow (Name, DataCenterID, ZoneID) VALUES
('AI Training Row', 1, 0),
('AI Inference Row', 1, 0),
('Management Row', 1, 0);

-- 5. Create cabinets
INSERT IGNORE INTO fac_Cabinet (
    DataCenterID, Location, LocationSortable, AssignedTo, ZoneID, CabRowID,
    CabinetHeight, Model, MaxKW, MaxWeight, InstallationDate, FrontEdge
) VALUES
(1, 'AI-TRAIN-01', 'AI-T-001', 0, 0, 1, 42, 'Standard 42U', 25, 2000, CURDATE(), 'Top'),
(1, 'AI-TRAIN-02', 'AI-T-002', 0, 0, 1, 42, 'Standard 42U', 25, 2000, CURDATE(), 'Top'),
(1, 'AI-INFER-01', 'AI-I-001', 0, 0, 2, 42, 'Standard 42U', 30, 2000, CURDATE(), 'Top'),
(1, 'MGT-01', 'MGT-001', 0, 0, 3, 42, 'Standard 42U', 15, 1500, CURDATE(), 'Top');

-- 6. Create departments
INSERT IGNORE INTO fac_Department (Name, ExecSponsor) VALUES
('AI Research', 'Dr. María García'),
('ML Engineering', 'Dr. Carlos Rodríguez'),
('DevOps', 'Ing. Luis Fernández');

-- 7. Create GPU servers and infrastructure
INSERT IGNORE INTO fac_Device (
    Label, SerialNo, AssetTag, PrimaryIP, Owner, Cabinet, Position, Height,
    Ports, TemplateID, NominalWatts, PowerSupplyCount, DeviceType,
    InstallDate, Status, Notes
) VALUES
-- Training Servers (Cabinet 1) - DGX A100
('AI-TRAIN-SRV-01', 'DGX-A100-001', 'AI-T-001', '10.1.1.101', 0, 1, 1, 6, 8, 1, 6500, 4, 'Server', CURDATE(), 'Production', 'LLM Training: GPT Models'),
('AI-TRAIN-SRV-02', 'DGX-A100-002', 'AI-T-002', '10.1.1.102', 0, 1, 8, 6, 8, 1, 6500, 4, 'Server', CURDATE(), 'Production', 'LLM Training: BERT Models'),
('AI-TRAIN-SRV-03', 'DGX-A100-003', 'AI-T-003', '10.1.1.103', 0, 1, 15, 6, 8, 1, 6500, 4, 'Server', CURDATE(), 'Production', 'Computer Vision Training'),
('AI-TRAIN-SRV-04', 'DGX-A100-004', 'AI-T-004', '10.1.1.104', 0, 1, 22, 6, 8, 1, 6500, 4, 'Server', CURDATE(), 'Production', 'Multimodal AI Training'),

-- Training Servers (Cabinet 2) - DGX A100
('AI-TRAIN-SRV-05', 'DGX-A100-005', 'AI-T-005', '10.1.1.105', 0, 2, 1, 6, 8, 1, 6500, 4, 'Server', CURDATE(), 'Production', 'Reinforcement Learning'),
('AI-TRAIN-SRV-06', 'DGX-A100-006', 'AI-T-006', '10.1.1.106', 0, 2, 8, 6, 8, 1, 6500, 4, 'Server', CURDATE(), 'Production', 'Research Workloads'),
('AI-TRAIN-SRV-07', 'DGX-A100-007', 'AI-T-007', '10.1.1.107', 0, 2, 15, 6, 8, 1, 6500, 4, 'Server', CURDATE(), 'Production', 'NLP Model Development'),
('AI-TRAIN-SRV-08', 'DGX-A100-008', 'AI-T-008', '10.1.1.108', 0, 2, 22, 6, 8, 1, 6500, 4, 'Server', CURDATE(), 'Production', 'Time Series Analysis'),

-- Inference Servers (Cabinet 3) - DGX H100
('AI-INFER-SRV-01', 'DGX-H100-001', 'AI-I-001', '10.1.2.101', 0, 3, 1, 6, 8, 2, 10200, 4, 'Server', CURDATE(), 'Production', 'Real-time Inference: ChatBot API'),
('AI-INFER-SRV-02', 'DGX-H100-002', 'AI-I-002', '10.1.2.102', 0, 3, 8, 6, 8, 2, 10200, 4, 'Server', CURDATE(), 'Production', 'Real-time Inference: Computer Vision'),
('AI-INFER-SRV-03', 'DGX-H100-003', 'AI-I-003', '10.1.2.103', 0, 3, 15, 6, 8, 2, 10200, 4, 'Server', CURDATE(), 'Production', 'Batch Inference: Analytics'),
('AI-INFER-SRV-04', 'DGX-H100-004', 'AI-I-004', '10.1.2.104', 0, 3, 22, 6, 8, 2, 10200, 4, 'Server', CURDATE(), 'Production', 'Model Serving Platform'),

-- Management Servers (Cabinet 4) - Dell R750
('K8S-MASTER-01', 'R750-001', 'K8S-M-001', '10.1.4.201', 0, 4, 1, 2, 8, 3, 800, 2, 'Server', CURDATE(), 'Production', 'Kubernetes Master Node 1'),
('K8S-MASTER-02', 'R750-002', 'K8S-M-002', '10.1.4.202', 0, 4, 4, 2, 8, 3, 800, 2, 'Server', CURDATE(), 'Production', 'Kubernetes Master Node 2'),
('MONITOR-SRV-01', 'R750-003', 'MON-001', '10.1.4.203', 0, 4, 7, 2, 8, 3, 800, 2, 'Server', CURDATE(), 'Production', 'Prometheus + Grafana Monitoring'),
('STORAGE-SRV-01', 'R750-004', 'STO-001', '10.1.4.204', 0, 4, 10, 2, 8, 3, 800, 2, 'Server', CURDATE(), 'Production', 'MinIO Object Storage');

-- 8. Create tags for organization (using correct field name)
INSERT IGNORE INTO fac_Tags (Name) VALUES
('AI-Training'),
('AI-Inference'),
('GPU-Compute'),
('Critical-Production'),
('Management'),
('High-Power');

-- 9. Add virtual machines for demonstration (using correct field structure)
INSERT IGNORE INTO fac_VMInventory (
    DeviceID, vmID, vmName, vmState, Owner, PrimaryContact, LastUpdated
) VALUES
(13, 1001, 'kubernetes-api-server', 'on', 0, 0, NOW()),
(13, 1002, 'etcd-cluster-node-1', 'on', 0, 0, NOW()),
(14, 1003, 'kubernetes-scheduler', 'on', 0, 0, NOW()),
(14, 1004, 'etcd-cluster-node-2', 'on', 0, 0, NOW()),
(15, 1005, 'prometheus-monitoring', 'on', 0, 0, NOW()),
(15, 1006, 'grafana-dashboards', 'on', 0, 0, NOW()),
(15, 1007, 'alertmanager', 'on', 0, 0, NOW()),
(16, 1008, 'minio-storage-node-1', 'on', 0, 0, NOW()),
(16, 1009, 'minio-storage-node-2', 'on', 0, 0, NOW()),
(16, 1010, 'jupyterhub-ai-research', 'on', 0, 0, NOW());

-- Final Summary:
-- ✅ 1 AI Research Data Center (5MW capacity)
-- ✅ 4 Cabinets (2 training, 1 inference, 1 management)
-- ✅ 8 Training Servers (DGX A100) - 52kW total
-- ✅ 4 Inference Servers (DGX H100) - 40.8kW total
-- ✅ 4 Management Servers (Dell R750) - 3.2kW total
-- ✅ 16 Physical Servers - 96kW total consumption
-- ✅ 10 Virtual Machines for K8s, monitoring, storage
-- ✅ 6 Tags for organization and filtering
-- ✅ 3 Departments with executive sponsors
-- ✅ Realistic IP addressing and asset tags
-- ✅ Production status devices with detailed notes