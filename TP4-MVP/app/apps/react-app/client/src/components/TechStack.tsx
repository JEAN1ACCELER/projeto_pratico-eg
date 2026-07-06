import { Card, CardContent, CardHeader, CardTitle } from "@/components/ui/card";

export default function TechStack() {
  const techStack = [
    { category: "Frontend", items: ["React 19", "TypeScript", "Tailwind CSS 4", "shadcn/ui", "Recharts", "tRPC"] },
    { category: "Backend", items: ["Express.js", "tRPC", "Drizzle ORM"] },
    { category: "Database", items: ["MySQL/TiDB"] },
    { category: "Build", items: ["Vite", "Vitest"] },
    { category: "Auth", items: ["Manus OAuth"] },
  ];

  return (
    <div className="space-y-6">
      <Card>
        <CardHeader>
          <CardTitle>Stack Tecnológica</CardTitle>
        </CardHeader>
        <CardContent>
          <div className="grid gap-4 md:grid-cols-2 lg:grid-cols-3">
            {techStack.map((stack, index) => (
              <div key={index} className="border rounded-lg p-4">
                <h3 className="text-lg font-semibold mb-2">{stack.category}</h3>
                <ul className="list-disc list-inside space-y-1">
                  {stack.items.map((item, itemIndex) => (
                    <li key={itemIndex}>{item}</li>
                  ))}
                </ul>
              </div>
            ))}
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
