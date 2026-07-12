import { inlinePsqlIncludes } from '../src/infrastructure/seed/boot-seed';

describe('boot-seed inlinePsqlIncludes', () => {
  it('\\ir yönergesini dosya içeriğiyle satır-içi açar', () => {
    const sql = 'INSERT INTO a VALUES (1);\n\\ir parca.sql\nINSERT INTO b VALUES (2);';
    const out = inlinePsqlIncludes(sql, '/base', (p) => {
      expect(p).toBe('/base/parca.sql');
      return '-- dahil edilen\nINSERT INTO c VALUES (3);';
    });
    expect(out).toContain('INSERT INTO a VALUES (1);');
    expect(out).toContain('INSERT INTO c VALUES (3);');
    expect(out).toContain('INSERT INTO b VALUES (2);');
    expect(out).not.toContain('\\ir');
  });

  it('include yoksa metni aynen döndürür', () => {
    const sql = 'SELECT 1;\nSELECT 2;';
    expect(inlinePsqlIncludes(sql, '/x', () => 'OLMAMALI')).toBe(sql);
  });

  it('girintili \\ir satırını da tanır', () => {
    const out = inlinePsqlIncludes('  \\ir alt/dosya.sql  ', '/kök', () => 'İÇERİK');
    expect(out).toBe('İÇERİK');
  });
});
