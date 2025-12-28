export abstract class FactoryNodeBaseRepository {
  abstract findAll(): Promise<any[]> | any[];
}
