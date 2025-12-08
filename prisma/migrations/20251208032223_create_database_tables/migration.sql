-- CreateEnum
CREATE TYPE "NodeType" AS ENUM ('ENTERPRISE', 'SITE', 'AREA', 'LINE', 'WORKCELL');

-- CreateEnum
CREATE TYPE "DriverProtocol" AS ENUM ('S7_COMM', 'ETHERNET_IP', 'MODBUS_TCP', 'OPC_UA', 'MQTT', 'HTTP_REST');

-- CreateEnum
CREATE TYPE "AlarmSeverity" AS ENUM ('CRITICAL', 'HIGH', 'MEDIUM', 'LOW', 'EXTERNAL');

-- CreateEnum
CREATE TYPE "AlarmStatus" AS ENUM ('ACTIVE', 'ACKNOWLEDGED', 'CLEARED');

-- CreateEnum
CREATE TYPE "UserRole" AS ENUM ('ADMIN', 'ENGINEER', 'OPERATOR', 'VIEWER');

-- CreateTable
CREATE TABLE "factory_nodes" (
    "id" SERIAL NOT NULL,
    "parent_id" INTEGER,
    "name" VARCHAR(100) NOT NULL,
    "description" TEXT,
    "type" "NodeType" NOT NULL,

    CONSTRAINT "factory_nodes_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "equipments" (
    "id" SERIAL NOT NULL,
    "node_id" INTEGER NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "description" TEXT,
    "image_url" TEXT,
    "is_active" BOOLEAN NOT NULL DEFAULT true,

    CONSTRAINT "equipments_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "data_sources" (
    "id" SERIAL NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "protocol" "DriverProtocol" NOT NULL,
    "connection_params" TEXT NOT NULL,
    "scan_rate_ms" INTEGER NOT NULL DEFAULT 1000,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "data_sources_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tags" (
    "id" SERIAL NOT NULL,
    "equipment_id" INTEGER NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "unit" VARCHAR(20),
    "data_type" TEXT NOT NULL DEFAULT 'float',
    "uns_path" VARCHAR(255) NOT NULL,

    CONSTRAINT "tags_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "tag_mappings" (
    "id" SERIAL NOT NULL,
    "tag_id" INTEGER NOT NULL,
    "data_source_id" INTEGER NOT NULL,
    "address" VARCHAR(255) NOT NULL,
    "scale_enable" BOOLEAN NOT NULL DEFAULT false,
    "raw_min" DOUBLE PRECISION,
    "raw_max" DOUBLE PRECISION,
    "eng_min" DOUBLE PRECISION,
    "eng_max" DOUBLE PRECISION,

    CONSTRAINT "tag_mappings_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "raw_telemetry" (
    "time" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tag_id" INTEGER NOT NULL,
    "value" DOUBLE PRECISION NOT NULL,
    "quality" INTEGER NOT NULL DEFAULT 192,

    CONSTRAINT "raw_telemetry_pkey" PRIMARY KEY ("time","tag_id")
);

-- CreateTable
CREATE TABLE "analyzed_data" (
    "time" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tag_id" INTEGER NOT NULL,
    "value" DOUBLE PRECISION NOT NULL,
    "metric_type" VARCHAR(20) NOT NULL,

    CONSTRAINT "analyzed_data_pkey" PRIMARY KEY ("time","tag_id","metric_type")
);

-- CreateTable
CREATE TABLE "ai_anomalies" (
    "time" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "tag_id" INTEGER NOT NULL,
    "score" DOUBLE PRECISION NOT NULL,
    "value" DOUBLE PRECISION NOT NULL,

    CONSTRAINT "ai_anomalies_pkey" PRIMARY KEY ("time","tag_id")
);

-- CreateTable
CREATE TABLE "alarm_rules" (
    "id" SERIAL NOT NULL,
    "equipment_id" INTEGER NOT NULL,
    "name" VARCHAR(100) NOT NULL,
    "description" TEXT,
    "severity" "AlarmSeverity" NOT NULL,
    "enabled" BOOLEAN NOT NULL DEFAULT true,
    "condition" VARCHAR(500) NOT NULL,

    CONSTRAINT "alarm_rules_pkey" PRIMARY KEY ("id")
);

-- CreateTable
CREATE TABLE "alarm_history" (
    "time" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "equipment_id" INTEGER NOT NULL,
    "rule_id" INTEGER,
    "message" VARCHAR(255) NOT NULL,
    "severity" "AlarmSeverity" NOT NULL,
    "source" VARCHAR(50) NOT NULL,
    "status" "AlarmStatus" NOT NULL,
    "ack_by" TEXT,
    "ack_time" TIMESTAMP(3),
    "snapshot" TEXT,

    CONSTRAINT "alarm_history_pkey" PRIMARY KEY ("time","equipment_id","message")
);

-- CreateTable
CREATE TABLE "users" (
    "id" SERIAL NOT NULL,
    "name" TEXT NOT NULL,
    "email" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" "UserRole" NOT NULL DEFAULT 'VIEWER',
    "active" BOOLEAN NOT NULL DEFAULT true,
    "created_at" TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT "users_pkey" PRIMARY KEY ("id")
);

-- CreateIndex
CREATE UNIQUE INDEX "data_sources_name_key" ON "data_sources"("name");

-- CreateIndex
CREATE UNIQUE INDEX "tags_uns_path_key" ON "tags"("uns_path");

-- CreateIndex
CREATE UNIQUE INDEX "tag_mappings_tag_id_key" ON "tag_mappings"("tag_id");

-- CreateIndex
CREATE UNIQUE INDEX "users_email_key" ON "users"("email");

-- AddForeignKey
ALTER TABLE "factory_nodes" ADD CONSTRAINT "factory_nodes_parent_id_fkey" FOREIGN KEY ("parent_id") REFERENCES "factory_nodes"("id") ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "equipments" ADD CONSTRAINT "equipments_node_id_fkey" FOREIGN KEY ("node_id") REFERENCES "factory_nodes"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tags" ADD CONSTRAINT "tags_equipment_id_fkey" FOREIGN KEY ("equipment_id") REFERENCES "equipments"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tag_mappings" ADD CONSTRAINT "tag_mappings_tag_id_fkey" FOREIGN KEY ("tag_id") REFERENCES "tags"("id") ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "tag_mappings" ADD CONSTRAINT "tag_mappings_data_source_id_fkey" FOREIGN KEY ("data_source_id") REFERENCES "data_sources"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "raw_telemetry" ADD CONSTRAINT "raw_telemetry_tag_id_fkey" FOREIGN KEY ("tag_id") REFERENCES "tags"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "analyzed_data" ADD CONSTRAINT "analyzed_data_tag_id_fkey" FOREIGN KEY ("tag_id") REFERENCES "tags"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "ai_anomalies" ADD CONSTRAINT "ai_anomalies_tag_id_fkey" FOREIGN KEY ("tag_id") REFERENCES "tags"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "alarm_rules" ADD CONSTRAINT "alarm_rules_equipment_id_fkey" FOREIGN KEY ("equipment_id") REFERENCES "equipments"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "alarm_history" ADD CONSTRAINT "alarm_history_equipment_id_fkey" FOREIGN KEY ("equipment_id") REFERENCES "equipments"("id") ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE "alarm_history" ADD CONSTRAINT "alarm_history_rule_id_fkey" FOREIGN KEY ("rule_id") REFERENCES "alarm_rules"("id") ON DELETE SET NULL ON UPDATE CASCADE;
